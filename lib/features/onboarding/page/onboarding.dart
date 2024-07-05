import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/onboarding/widgets/page_one.dart';
import 'package:todo/features/onboarding/widgets/page_two.dart';

class OnBoarding extends StatefulWidget{
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  final PageController pageController=PageController();

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              PageOne(),
              PageTwo()
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4*w,vertical: 4*w),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          pageController.nextPage(
                              duration: const Duration(microseconds: 600),
                              curve: Curves.ease);
                        },
                        child: const Icon(
                          Icons.keyboard_double_arrow_right, size: 22, color: AppConst.white),
                      ),
                      SizedBox(width: 2*w),
                      ReusableText(text: 'Skip', style: appstyle(15, AppConst.white, FontWeight.w400),)
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      pageController.nextPage(
                          duration: const Duration(microseconds: 600),
                          curve: Curves.ease);
                    },
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: 2,
                        effect:  WormEffect(
                          dotHeight: 3.3*w,
                          dotWidth: 3.3*w,
                          dotColor: AppConst.yellow,
                          spacing: 3*w
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }}