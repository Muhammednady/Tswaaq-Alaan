import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/modules/homepage/homepage.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/consonents.dart';
import 'package:shopping_app/shared/cubit/login_cubit.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/network/local/shared_preferences.dart';
import 'package:shopping_app/shared/states/login_states.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../register_screen/register_screen.dart';

class LogInSCreen extends StatelessWidget {
  LogInSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LOGINCubit>(
      create: (context) => LOGINCubit(),
      child: BlocConsumer<LOGINCubit, LogInStates>(
        listener: (context, state) {
          if (state is LogInSuccessState) {
            if (state.shopLogInModel!.status!) {
              // BlocProvider.of<ShopLayoutCubit>(context).getUserData(state.shopLogInModel!.data!.token!);
              showToast(state.shopLogInModel!.message!, ToastStates.SUCCESS);
              print('================ state.shopLogInModel!.data!.token!=====');
              print(state.shopLogInModel!.data!.token!);
              CachHelper.setToken(state.shopLogInModel!.data!.token!)
                  .then((bool value) {
                   userToken = state.shopLogInModel!.data!.token!;
                if (value) {
                  navigateToAndRemove(const ShopLayout(), context);
                }
              });
            } else {
              showToast(state.shopLogInModel!.message!, ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          LOGINCubit cubit = LOGINCubit.get(context);
          // ShopLayoutCubit cubit8 = BlocProvider.of<ShopLayoutCubit>(context);
          // cubit8.getUserData(token);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOG IN',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Login now to browse out hot offers',
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'Email Address',
                              type: TextInputType.emailAddress,
                              controll: emailController,
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your email address ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'password',
                              type: TextInputType.visiblePassword,
                              controll: passwordController,
                              isPassword: cubit.isPassword,
                              prefix: cubit.prefixIcon,
                              suffix: cubit.suffixIcon,
                              onSubmit: (value) {
                                cubit.logIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              },
                              suffixpressed: () {
                                cubit.changePasswordState();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password can\'t be empty ';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          state is LogInLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.logIn(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  isUppercase: true,
                                  text: 'log in'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              // SizedBox(width: 5.0,),
                              defaultTextButton(
                                  text: 'register',
                                  F: () {
                                    navigateToAndRemove(
                                        RegisterSCreen(), context);
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
