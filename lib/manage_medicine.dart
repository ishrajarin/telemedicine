import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ManageMedicine extends StatefulWidget {
  const ManageMedicine({Key? key}) : super(key: key);
  @override
  ManageMedicineState createState() => ManageMedicineState();
}

class ManageMedicineState extends State<ManageMedicine> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    showNotification();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@drawable/ic_stat_ic_notification',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Running out of medication!',
      'Please refill your Pulmicort Budesonide before 2th September 2024.',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E9FF), // Light blue background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.autorenew,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Ongoing",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const CircularProgressIndicator(
                              value: 0.25, // This represents the 75% progress
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF757575),
                              ),
                              backgroundColor: Color(0xFF247B7B),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '75%',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Calendar Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "August 2024",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Days Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final dayOfWeek = [
                          'Sat',
                          'Sun',
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri'
                        ][index];
                        return Column(
                          children: [
                            Text(
                              dayOfWeek,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 5),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: index == 5
                                  ? const Color(0xFF247B7B)
                                  : Colors.transparent,
                              child: Text(
                                '${index + 24}',
                                style: TextStyle(
                                  color:
                                  index == 5 ? Colors.white : Colors.black,
                                  fontWeight: index == 5
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    // Medication List
                    Expanded(
                      child: ListView(
                        children: const [
                          MedicationTimeSlot(
                            time: "9:00 AM",
                            medications: ["Amoxicillin", "Metformin"],
                          ),
                          MedicationTimeSlot(
                            time: "5:00 PM",
                            medications: ["Amoxicillin", "Metformin"],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicationTimeSlot extends StatefulWidget {
  final String time;
  final List<String> medications;

  const MedicationTimeSlot({
    Key? key,
    required this.time,
    required this.medications,
  }) : super(key: key);

  @override
  MedicationTimeSlotState createState() => MedicationTimeSlotState();
}

class MedicationTimeSlotState extends State<MedicationTimeSlot> {
  final Map<String, bool> _checkedMedications = {};

  @override
  void initState() {
    super.initState();
    for (var medication in widget.medications) {
      _checkedMedications[medication] = false;
    }
  }

  void _toggleCheck(String medication) {
    setState(() {
      _checkedMedications[medication] = !_checkedMedications[medication]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.time,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...widget.medications.map((medication) {
            return Card(
              color: const Color(
                  0xFFE6E9FF), // Light blue background for medication card
              child: ListTile(
                title: Text(
                  medication,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "Take 1 capsule orally (Before or after food)",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Icon(
                  _checkedMedications[medication]!
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: const Color(
                      0xFF247B7B), // Dark green for the radio button
                ),
                onTap: () => _toggleCheck(medication),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
