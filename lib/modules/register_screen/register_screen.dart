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
import '../login_screen/loginScreen.dart';
import '../register_screen/register_screen.dart';

class RegisterSCreen extends StatelessWidget {
  RegisterSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LOGINCubit>(
      create: (context) => LOGINCubit(),
      child: BlocConsumer<LOGINCubit, LogInStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.shopRegisterModel!.status!) {
              showToast(state.shopRegisterModel!.message!, ToastStates.SUCCESS);
              CachHelper.setToken(state.shopRegisterModel!.data!.token!)
                  .then((bool value) {
                userToken = state.shopRegisterModel!.data!.token!;
                if (value) {
                  navigateToAndRemove(const ShopLayout(), context);
                }
              });
            } else {
              showToast(state.shopRegisterModel!.message!, ToastStates.ERROR);
            }
          }
          if (state is RegisterErrorState) {
            showToast(state.error, ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          LOGINCubit cubit = LOGINCubit.get(context);
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
                            'register'.toUpperCase(),
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
                          Text('Register now to browse out hot offers',
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'Name',
                              type: TextInputType.name,
                              controll: nameController,
                              prefix: Icons.person_2_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your name ';
                                }
                                return null;
                              }),
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
                          DefaultTextFormField(
                              label: 'Phone',
                              type: TextInputType.phone,
                              controll: phoneController,
                              prefix: Icons.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your phone ';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          state is RegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text);
                                    } else {
                                      showToast('Please,Correct your inputs',
                                          ToastStates.WARNING);
                                    }
                                  },
                                  isUppercase: true,
                                  text: 'Register'),
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
