import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puvts_driver/features/login_signup/presentation/screens/login_view.dart';
import 'app/locator_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
