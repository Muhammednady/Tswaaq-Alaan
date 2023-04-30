import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/shared/cubit/boardingcubit.dart';

import '../../models/onboardingmodel.dart';
import '../../modules/login_screen/loginScreen.dart';
import '../consonents.dart';
import '../network/local/shared_preferences.dart';

Widget BuildBoardItem(BoardingModel model, BuildContext context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('${model.image}')),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "${model.title}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("${model.body}", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );

void navigateToAndRemove(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => false);

void navigateToAndSave(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => true);

Widget DefaultTextFormField({
  String? hintText,
  required String? label,
  required TextInputType type,
  required TextEditingController? controll,
  void Function()? onclicked,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixpressed,
  void Function(String)? onSubmit,
  required String? Function(String?) validate,
}) =>
    TextFormField(
      validator: validate,
      controller: controll,
      obscureText: isPassword,
      keyboardType: type,
      onTap: onclicked,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        hintText: hintText,
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  Color color = Colors.blue,
  bool isUppercase = false,
  required Function() onpressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
          onPressed: onpressed,
          child: Text(
            '${isUppercase ? text.toUpperCase() : text}',
            style: TextStyle(color: Colors.white),
          )),
    );

Widget defaultTextButton({required String text, required Function() F}) =>
    TextButton(
      onPressed: F,
      child: Text('${text.toUpperCase()}'),
    );

void showToast(String message, ToastStates state) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: resolveToastStates(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color resolveToastStates(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

void logout(context) {
  CachHelper.deleteToken(TOKEN).then((value) {
    if (value) {
      navigateToAndRemove(LogInSCreen(), context);
    }
  });
}
