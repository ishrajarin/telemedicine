import 'package:flutter/material.dart';

class DoctorsListPage extends StatefulWidget {
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  int _selectedIndex = 1; // Set to 1 because this is the Doctors tab

  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')), // Replace with your Home Page widget
    DoctorsListPageContent(), // Actual Doctors List
    Center(child: Text('Settings Page Content')), // Replace with other tab content
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Dynamically switch between pages
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DoctorsListPageContent extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Md. Mahbubul Islam',
      'specialty': 'General Physician',
      'location': 'PG Hospital, Dhaka',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Dr. Ayesha Rahman',
      'specialty': 'Cardiologist',
      'location': 'United Hospital, Dhaka',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Dr. Tanvir Ahmed',
      'specialty': 'Dentist',
      'location': 'Apollo Hospital, Dhaka',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Doctors List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search doctor, specialty, or hospital...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.filter_list, color: Colors.blue),
                label: Text('Filters', style: TextStyle(color: Colors.blue)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    name: doctor['name']!,
                    specialty: doctor['specialty']!,
                    location: doctor['location']!,
                    image: doctor['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;
  final String image;

  DoctorCard({
    required this.name,
    required this.specialty,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(specialty, style: TextStyle(color: Colors.grey.shade600)),
                  SizedBox(height: 4),
                  Text(location, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Book'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
