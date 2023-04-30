import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/onboardingmodel.dart';
import 'package:shopping_app/shared/cubit/boardingcubit.dart';
import 'package:shopping_app/shared/network/local/shared_preferences.dart';
import 'package:shopping_app/shared/states/boardingstates.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_screen/loginScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/themes.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  List<BoardingModel> screenItems = [
    BoardingModel("assets/images/shopping1.jpg", 'onBoarding title 1',
        'onBoarding body 1'),
    BoardingModel("assets/images/shopping2.jpg", 'onBoarding title 2',
        'onBoarding body 2'),
    BoardingModel("assets/images/shoppingHall.jpg", 'onBoarding title 3',
        'onBoarding body 3')
  ];

  PageController pageController = PageController();
  bool isLast = false;

  void submit(context) {
    CachHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateToAndRemove(LogInSCreen(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Boarding Screen"),
          actions: [
            TextButton(
                onPressed: () {
                  submit(context);
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(fontFamily: 'goodFont'),
                ))
          ],
        ),
        body: Column(children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                print(' $value ::========== onChanged ========');

                if (value == screenItems.length - 1) {
                  isLast = true;
                } else {
                  isLast = false;
                }
              },
              physics: BouncingScrollPhysics(),
              itemCount: screenItems.length,
              itemBuilder: (context, index) =>
                  BuildBoardItem(screenItems[index], context),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: screenItems.length,
                  effect: const ColorTransitionEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 20.0,
                    dotWidth: 20.0,
                    //strokeWidth: 10.0
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'arrowForward',
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ]));
  }
}
