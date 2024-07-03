//import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/sell_page.dart';
import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/services/auth/auth_service.dart';
//import 'package:chatapp/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home':(context) => HomePage(),
        '/sell': (context) => SellPage()
      },
      home: SellPage(),
    );
  }
}
