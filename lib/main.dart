import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/layout/shop_layout/shop_layout.dart';
import 'package:shopping_app/modules/homepage/homepage.dart';
import 'package:shopping_app/modules/onBoarding/onboarding.dart';
import 'package:shopping_app/shared/consonents.dart';
import 'package:shopping_app/shared/cubit/shoplayout_cubit.dart';
import 'package:shopping_app/shared/network/certificate_resolver.dart';
import 'package:shopping_app/shared/network/local/shared_preferences.dart';
import 'package:shopping_app/shared/network/remote.dart';
import 'package:shopping_app/shared/network/local/shared_preferences.dart';
import 'package:shopping_app/shared/styles/themes.dart';
import 'package:shopping_app/shared/cubit/boardingcubit.dart';

import 'modules/login_screen/loginScreen.dart';
import 'shared/network/local/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await CachHelper.init();
  DioHelper.init();
  Widget screen = OnBoardingScreen();
  bool? onBoarding = CachHelper.getOnBoarding;
  userToken = CachHelper.getToken;
  print('====================== Token from Main =======================');
  print('token is : $userToken');

  if (onBoarding != null) {
    if (userToken == null) {
      screen = LogInSCreen();
    } else {
      screen = ShopLayout();
    }
  }

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
  final Widget currentScreen;

  MyApp(this.currentScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BoardingCubit>(
          create: (context) => BoardingCubit(),
        ),
        BlocProvider<ShopLayoutCubit>(
          create: (context) => ShopLayoutCubit()
            ..getUserData(userToken)
            ..getCategories()
            ..getFavorites(userToken)
            ..getProfile(userToken)
        )
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: currentScreen,
      ),
    );
  }
}

