import 'package:course_notification_app/notified_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotifiedProvider>();

    return Scaffold(
      body: Container(
        color: Colors.blue[300],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Every Sunday & Tuesday',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '''
    
    - 3:00 pm : Ice breaker 
    - 3:10 pm : Full English
    - 4:25 pm : Break
    - 4:35 pm : Full Arabic
    - 5:00 pm : The end of session
          ''',
            style: TextStyle(fontSize: 20),
          ),
           GestureDetector(
                  onTap: () {
                    provider.hasNotifications
                        ? provider.cancelAllNotifications()
                        : provider.setNotifications();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: provider.hasNotifications
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      provider.hasNotifications ? 'Stop' : 'Start',
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
        ]),
      ),
    );
  }
}
