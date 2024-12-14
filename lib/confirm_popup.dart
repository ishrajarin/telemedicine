import 'package:flutter/material.dart';
import 'package:tele_medicine/firebase_auth_check.dart';

class ScheduledPopup extends StatelessWidget {
  const ScheduledPopup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Implement navigation back
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FirebaseAuthCheck()), // Replace HomeScreen with your home screen widget
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top -
              60.0, // Subtracting the app bar height and padding
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Doctor Image
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage("assets/images/doctorconsultation2.jpg"),
                ),
                const SizedBox(height: 20),

                // Meeting Info
                const Text(
                  'Your upcoming virtual meeting with Dr. Lebron James has been scheduled',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Date & Time
                const Text(
                  '30th August 2024 (Friday) at 11:00AM',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),

                // Booking ID
                const Text(
                  'Booking id: #3399QwE',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 20),

                // Divider
                Divider(color: Colors.grey[300]),

                // Option 1: Test Device
                ListTile(
                  leading: const Icon(Icons.videocam, color: Color(0xFFA4A5FF)),
                  title: const Text('Test your device prior to visit'),
                  subtitle: const Text(
                      'Make sure video, audio and internet connections are working.'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {
                    // Add logic to test the device
                  },
                ),

                // Option 2: Schedule another appointment
                ListTile(
                  leading: const Icon(Icons.calendar_today,
                      color: Colors.blueAccent),
                  title: const Text('Schedule another Appointment'),
                  subtitle: const Text(
                      'Schedule an appointment with available doctors.'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {
                    // Add logic to schedule another appointment
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
