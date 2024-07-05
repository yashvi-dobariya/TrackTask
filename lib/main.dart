import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/model/user_model.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/features/auth/controllers/user_controller.dart';
import 'package:todo/features/onboarding/page/onboarding.dart';
import 'package:todo/features/todo/page/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme=ColorScheme.fromSwatch(
    primarySwatch: AppConst.sky
  );

  static final defaultDarkColorScheme=ColorScheme.fromSwatch(
      primarySwatch: AppConst.sky,
      brightness:Brightness.dark
  );

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users=ref.watch(userProvider);

    SizeConfig().init(context);
    return DynamicColorBuilder(
      builder: (lightColorScheme,darkColorScheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //primarySwatch:Colors.grey,
            scaffoldBackgroundColor: AppConst.grey.shade800,
            colorScheme: lightColorScheme ??defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme??defaultDarkColorScheme,
            scaffoldBackgroundColor: AppConst.grey.shade800,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          home: users.isEmpty? const OnBoarding():const HomePage(),
          onGenerateRoute: Routes.generateRoute,
        );
      }
    );
  }
}