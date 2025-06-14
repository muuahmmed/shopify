import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/views/home/home_cubit/home_cubit.dart';
import 'package:shopify/views/home/main_home_screen.dart';
import 'package:shopify/views/login/login.dart';
import 'package:shopify/views/login/login_cubit/login_cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding') as bool?;
  String? token = CacheHelper.getData(key: 'token') as String?;
  bool? isGoogleSignedIn = CacheHelper.getData(key: 'isGoogleSignedIn') as bool?;

  Widget startWidget = const LoginScreen(); // Default

  if (onBoarding == true && token != null && token.isNotEmpty) {
    startWidget = const MainHomeScreen();
  } else if (isGoogleSignedIn == true) {
    startWidget = const MainHomeScreen();
  }

  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeShopCubit()),
        BlocProvider(create: (context) => LoginShopCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
