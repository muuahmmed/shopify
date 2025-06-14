import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/network/local/cache_helper.dart';
import '../../../models/user_model.dart';
import 'login_states.dart';

class LoginShopCubit extends Cubit<LoginShopStates> {
  LoginShopCubit() : super(LoginShopInitialState());

  Future<void> userLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginShopLoadingState());
    try {
      // Here you would normally call your authentication API
      // For now, we'll simulate a successful login
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay

      // Create a user model (replace with actual API response)
      final user = UserModel(
        uId: 'generated-user-id-123', // Should come from your backend
        name: email.split('@').first, // Temporary name
        email: email,
      );

      // Cache user data
      await _cacheUserData(user, rememberMe: rememberMe);

      emit(LoginShopSuccessState('Login successful'));
    } catch (e, stackTrace) {
      emit(LoginShopErrorState(e.toString()));
    }
  }

  Future<void> _cacheUserData(
    UserModel user, {
    required bool rememberMe,
  }) async {
    try {
      // Cache essential user data
      await CacheHelper.saveData(key: 'token', value: user.uId);
      await CacheHelper.saveData(key: 'email', value: user.email);
      await CacheHelper.saveData(key: 'name', value: user.name);

      // If remember me is true, cache the credentials
      if (rememberMe) {
        await CacheHelper.saveData(key: 'rememberMe', value: true);
      } else {
        await CacheHelper.removeData(key: 'rememberMe');
      }

      // Mark onboarding as complete
      await CacheHelper.saveData(key: 'onBoarding', value: true);
    } catch (e) {
      throw Exception('Failed to cache user data: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgoShopPasswordLoadingState());
    try {
      // Simulate network call
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ForgoShopPasswordSuccessState('Password reset email sent to $email'),
      );
    } catch (e, stackTrace) {
      emit(ForgoShopPasswordErrorState(e.toString()));
    }
  }

  Future<void> userLogout() async {
    try {
      // Clear all cached user data
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'email');
      await CacheHelper.removeData(key: 'name');
      await CacheHelper.removeData(key: 'rememberMe');
      await CacheHelper.removeData(key: 'isGoogleSignedIn');

      // Keep onboarding as true since they've already seen it
      emit(LoginShopInitialState());
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginShopLoadingState());
    try {
      // Implement Google Sign-In logic here
      // This is platform specific (requires firebase_auth package)

      // After successful Google sign-in:
      final user = UserModel(
        uId: 'google-user-id', // Get from Google auth
        name: 'Google User', // Get from Google profile
        email: 'googleuser@example.com', // Get from Google profile
      );

      await _cacheUserData(user, rememberMe: true);
      await CacheHelper.saveData(key: 'isGoogleSignedIn', value: true);

      emit(LoginShopSuccessState('Google login successful'));
    } catch (e) {
      emit(LoginShopErrorState(e.toString()));
    }
  }
}
