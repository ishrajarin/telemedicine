import 'package:flutter/material.dart';
import 'package:tele_medicine/doctor_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seba'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Welcome to Seba!'),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Seba',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Doctors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorsListPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Consulting History'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to consulting history page if available
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite Doctors'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorite doctors page if available
            },
          ),
        ],
      ),
    );
  }
}

class DoctorPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. John Doe',
      'specialization': 'Cardiologist',
      'experience': '10 years',
    },
    {
      'name': 'Dr. Jane Smith',
      'specialization': 'Pediatrician',
      'experience': '8 years',
    },
    {
      'name': 'Dr. Robert Brown',
      'specialization': 'Dermatologist',
      'experience': '6 years',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(doctor['name']!),
            subtitle: Text(
              '${doctor['specialization']} - ${doctor['experience']} experience',
            ),
          );
        },
      ),
    );
  }
}
