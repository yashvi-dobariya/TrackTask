
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/auth/page/login_page.dart';
import 'package:todo/features/auth/page/otp_page.dart';
import 'package:todo/features/onboarding/page/onboarding.dart';
import 'package:todo/features/todo/page/homepage.dart';

class Routes{

  static const String onBoarding='onBoarding';
  static const String login='login';
  static const String otp='otp';
  static const String home='home';

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name)
    {
      case onBoarding:
        return MaterialPageRoute(builder: (BuildContext context)=> const OnBoarding());

      case login:
        return MaterialPageRoute(builder: (BuildContext context)=> const LoginPage());

      case otp:
        final Map args=settings.arguments as Map;
        return MaterialPageRoute(builder: (BuildContext context)=> OtpPage(smsCodeId: args['smsCodeId'], phone: args['phone']));

      case home:
        return MaterialPageRoute(builder: (BuildContext context)=> const HomePage());

      default:
        return MaterialPageRoute(builder: (_){
          return  const Scaffold(
            body: Center(
              child: Text('no route defined'),
            ),
          );
        });
    }
  }
}