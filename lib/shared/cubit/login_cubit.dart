import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/network/remote.dart';

import '../../models/shoplogin_model.dart';
import '../network/end_points.dart';
import '../states/login_states.dart';

class LOGINCubit extends Cubit<LogInStates> {
  LOGINCubit() : super(LogInInitialState());

  bool isPassword = true;
  IconData prefixIcon = Icons.lock_outlined;
  IconData suffixIcon = Icons.visibility_outlined;
  ShopLogInModel? shopLogInModel;

  static LOGINCubit get(context) => BlocProvider.of(context);

  void changePasswordState() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.lock_outlined : Icons.lock_open;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(PasswordChangeState());
  }

  logIn({
    required String email,
    required String password,
  }) {
    DioHelper.postData(
        url: LOGIN,
        data: {"email": "$email", "password": "$password"}).then((value) {
      shopLogInModel = ShopLogInModel.FromJson(value.data);
      print('===============================================');
      print(value.data['status']);
      print('===============================================');

      emit(LogInSuccessState(shopLogInModel));
    }).catchError((error) {
      print(error.toString());
      emit(LogInErrorState(error.toString()));
    });
  }
ShopLogInModel? registerModel;
  void register(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
         emit(RegisterLoadingState());
        DioHelper.postData(url: REGISTER,data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone
        }).then((value){
          registerModel = ShopLogInModel.FromJson(value.data);

          emit(RegisterSuccessState(registerModel));

        }).catchError((error){
          emit(RegisterErrorState(error.toString()));

        });
      }
}
