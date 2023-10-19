import 'package:course_notification_app/home_page.dart';
import 'package:course_notification_app/notified_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => NotifiedProvider(),
        child: const SafeArea(child: HomePage()),
      ),
    );
  }
}
