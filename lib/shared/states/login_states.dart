

import '../../models/shoplogin_model.dart';

abstract class LogInStates{}

class LogInInitialState extends LogInStates{}
class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{
   final ShopLogInModel? shopLogInModel;
   LogInSuccessState( this.shopLogInModel);

}
class LogInErrorState extends LogInStates{
  final String error;
  LogInErrorState(this.error);
}
class PasswordChangeState extends LogInStates{}

class RegisterLoadingState extends LogInStates{}
class RegisterSuccessState extends LogInStates{
   final ShopLogInModel? shopRegisterModel;
   RegisterSuccessState( this.shopRegisterModel);

}
class RegisterErrorState extends LogInStates{
  final String error;
  RegisterErrorState(this.error);
}
