abstract class LoginShopStates {}

class LoginShopInitialState extends LoginShopStates {}

class LoginShopLoadingState extends LoginShopStates {}

class LoginShopSuccessState extends LoginShopStates {
  final String message;

  LoginShopSuccessState(this.message);
}

class LoginShopErrorState extends LoginShopStates {
  final String error;

  LoginShopErrorState(this.error);
}

class ForgoShopPasswordLoadingState extends LoginShopStates {}

class ForgoShopPasswordSuccessState extends LoginShopStates {
  final String message;

  ForgoShopPasswordSuccessState(this.message);
}

class ForgoShopPasswordErrorState extends LoginShopStates {
  final String error;

  ForgoShopPasswordErrorState(this.error);
}
