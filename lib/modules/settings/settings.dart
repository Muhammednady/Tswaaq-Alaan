import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/login_screen/loginScreen.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/network/local/shared_preferences.dart';
import 'package:shopping_app/shared/states/shoplayout_states.dart';

import '../../shared/components/components.dart';
import '../../shared/consonents.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          if (state.updateModel.status!) {
            showToast(state.updateModel.message!, ToastStates.SUCCESS);
             ShopLayoutCubit.get(context).getProfile(userToken);
          } else {
            showToast(state.updateModel.message!, ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        if (cubit.profileModel!.data != null) {
          emailController.text = cubit.profileModel!.data!.email!;
          nameController.text = cubit.profileModel!.data!.name!;
          phoneController.text = cubit.profileModel!.data!.phone!;
        }
        
        return  cubit.profileModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is UpdateLoadingState)
                          LinearProgressIndicator(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DefaultTextFormField(
                            label: 'name',
                            type: TextInputType.name,
                            controll: nameController,
                            prefix: Icons.person_2_outlined,
                            validate: (text) {
                              if (text!.isEmpty) {
                                return 'Person name can\'t be empty';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        DefaultTextFormField(
                            label: 'email',
                            type: TextInputType.emailAddress,
                            controll: emailController,
                            prefix: Icons.email_outlined,
                            validate: (text) {
                              if (text!.isEmpty) {
                                return 'E-mail can\'t be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        DefaultTextFormField(
                            label: 'phone',
                            type: TextInputType.phone,
                            controll: phoneController,
                            prefix: Icons.phone_android_outlined,
                            validate: (text) {
                              if (text!.isEmpty) {
                                return 'Phone can\'t be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                            onpressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Update',
                            isUppercase: true),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                            onpressed: () {
                              logout(context);
                            },
                            text: 'Log out',
                            isUppercase: true),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
