import 'package:flutter/material.dart';

// Main Widget
class MedicalHistory extends StatelessWidget {
  const MedicalHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rounded Edge Background
          Container(
            margin:
            const EdgeInsets.only(top: 35.0), // Set the top margin to 35
            decoration: const BoxDecoration(
              color: Color.fromARGB(174, 174, 199, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            height: MediaQuery.of(context)
                .size
                .height, // Set height to screen height
            child: Column(
              children: [
                const SizedBox(height: 20.0), // Add spacing from the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Medical History',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.more_vert_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0), // Add spacing below the header
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: const [
                        MedicalCard(
                          icon: Icons.favorite,
                          title1: 'Medical Check-Up',
                          word: 'Dr. Mohamed',
                          id: 'Transaction ID: VITH111222',
                          title2: 'RM 150.00',
                          date: '2024-08-25',
                          time: '10:00 AM',
                        ),
                        MedicalCard(
                          icon: Icons.bloodtype,
                          title1: 'Blood Test',
                          word: 'Clinic Bersatu',
                          id: 'Transaction ID: VITH456789',
                          title2: 'RM 100.00',
                          date: '2024-07-20',
                          time: '08:00 AM',
                        ),
                        MedicalCard(
                          icon: Icons.medication,
                          title1: 'Medication',
                          word: 'Pharmacy Best',
                          id: 'Transaction ID: VITH121212',
                          title2: 'RM 89.00',
                          date: '2024-06-10',
                          time: '11:05 AM',
                        ),
                        MedicalCard(
                          icon: Icons.local_hospital,
                          title1: 'Cardiology Consultation',
                          word: 'Dr. Tan',
                          id: 'Transaction ID: VITH123456',
                          title2: 'RM 188.00',
                          date: '2024-06-10',
                          time: '11:00 AM',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicalCard extends StatelessWidget {
  final IconData icon;
  final String title1;
  final String word;
  final String id;
  final String title2;
  final String date;
  final String time;

  const MedicalCard({
    Key? key,
    required this.icon,
    required this.title1,
    required this.word,
    required this.id,
    required this.title2,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                    height: 8.0), // Adjust this value to move the icon down
                Center(
                  child: Icon(
                    icon,
                    size: 40.0,
                    color: const Color.fromRGBO(164, 165, 255, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(word),
                Text(id),
              ],
            ),
            const SizedBox(width: 32.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(date),
                Text(time),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
