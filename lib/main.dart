import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'initializer.dart';
import 'routes/page_names.dart';
import 'routes/page_routes.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (_, snap){
      if(snap.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      return Sizer(builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: snap.data != null ? PageName.ATTENDANCE : PageName.SPLASH,
          getPages: PageRoutes.pages,
          theme: AppTheme.buildThemeData(false),
          builder: (BuildContext context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0)
              ),
              child: child ?? Container(),
            );
          },
        );
      });
    }
  );
  }
}
