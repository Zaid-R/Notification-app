import 'package:course_notification_app/notified_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotifiedProvider>();
    
    return Scaffold(
      body: Container(
        color: Colors.blue[300],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildDaysTitle(),
                buildSections(),
                buildButton(provider),
              ])
            : Row(
                children: [
                  Column(
                    children: [
                      buildDaysTitle(),
                      buildSections(),
                    ],
                  ),
                  buildButton(provider),
                ],
              ),
      ),
    );
  }

  GestureDetector buildButton(NotifiedProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.hasNotifications
            ? provider.cancelAllNotifications()
            : provider.setNotifications();
      },
      child: Container(
        decoration: BoxDecoration(
            color: provider.hasNotifications ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          provider.hasNotifications ? 'Stop' : 'Start',
          style: const TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Text buildSections() {
    return const Text(
      '''
  
  - 3:00 pm : Ice breaker 
  - 3:10 pm : Full English
  - 4:25 pm : Break
  - 4:35 pm : Full Arabic
  - 5:00 pm : The end of session
        ''',
      style: TextStyle(fontSize: 20),
    );
  }

  Text buildDaysTitle() {
    return const Text(
      'Every Sunday & Tuesday',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
