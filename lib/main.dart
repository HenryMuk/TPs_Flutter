import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; 

import 'view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Firebase adaptée à toutes les plateformes
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 184, 157, 25)),
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
