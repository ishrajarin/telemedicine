import 'package:flutter/material.dart';
import 'package:tele_medicine/dailygoals.dart';
import 'package:tele_medicine/healthreport.dart';
import 'package:tele_medicine/message.dart';
import 'package:tele_medicine/setting.dart';
import 'manage_medicine.dart';
import 'manage_prescription.dart';
import 'community.dart';
import 'consultation.dart';
import 'models/user.dart';
import 'login.dart';
import 'firebase_auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'healthband.dart';
import 'dart:io';
import 'view_profile.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Default selected index
  bool _showIndicator = false; // Indicator visibility
  bool _isLoading = false; // Loading indicator visibility
  final AuthService _auth = AuthService();

  static const List<Widget> widgetOptions = <Widget>[
    // Add pages here
    ManageMedicine(),
    ManagePrescription(),
    Consultation(),
    Community(),
  ];

  void _precacheProfilePic(String profilePicUrl) {
    ImageProvider imageProvider;

    if (profilePicUrl != '' && profilePicUrl.isNotEmpty) {
      if (profilePicUrl.startsWith('http') ||
          profilePicUrl.startsWith('https')) {
        imageProvider = NetworkImage(profilePicUrl);
      } else {
        imageProvider = FileImage(File(profilePicUrl));
      }
    } else {
      imageProvider = const AssetImage('assets/images/default_avatar.png');
    }

    precacheImage(imageProvider, context);
  }

  void _topIconPressed(BuildContext context) {
    if (!_showIndicator) {
      // Collapsible sidebar here
      Scaffold.of(context).openDrawer(); // Open the drawer
    } else {
      setState(() {
        _showIndicator = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showIndicator = true;
    });
  }

  // Signout
  Future<void> _signOut() async {
    _isLoading = true;
    try {
      await _auth.signOut();
      // Clear user preferences except for 'onBoard'
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      for (String key in keys) {
        if (key != 'onBoard') {
          await prefs.remove(key);
        }
      }

      // Clear UserCredentials singleton instance
      UserCredentials().email = null;
      UserCredentials().uid = null;
      UserCredentials().displayName = null;
      UserCredentials().profilePicUrl = null;

      // Navigate back to login screen
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
              (Route<dynamic> route) =>
          false, // This condition removes all the previous routes
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch user details
    String? displayName = UserCredentials().displayName;
    String? profilePicUrl = UserCredentials().profilePicUrl;
    _precacheProfilePic(profilePicUrl ?? '');
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF757575),
            height: 1.0,
          ),
        ),
        elevation: 0.0,
        toolbarHeight: 66.0,
        titleSpacing: 7.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: !_showIndicator
                ? CircleAvatar(
              backgroundImage: profilePicUrl != null &&
                  profilePicUrl.isNotEmpty
                  ? (profilePicUrl.startsWith('http') ||
                  profilePicUrl.startsWith('https')
                  ? NetworkImage(profilePicUrl)
                  : FileImage(File(profilePicUrl))) as ImageProvider
                  : const AssetImage('assets/images/default_avatar.png'),
            )
                : const Icon(
              Icons.home,
              size: 35,
            ),
            onPressed: () {
              _topIconPressed(
                  context); // also switch between avatar and home icon
            },
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    isDense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                      color: Color(0xFF757575),
                    ),
                    hintText: 'Search Doctor, Medicine, Tests...',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF757575),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top: 25.0),
          decoration: const BoxDecoration(
            color: Color(0xFFDAE2FF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // User Profile Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: profilePicUrl != null &&
                          profilePicUrl.isNotEmpty
                          ? (profilePicUrl.startsWith('http') ||
                          profilePicUrl.startsWith('https')
                          ? NetworkImage(profilePicUrl)
                          : FileImage(File(profilePicUrl))) as ImageProvider
                          : const AssetImage(
                          'assets/images/default_avatar.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      displayName ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle view profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewProfile(),
                          ),
                        );
                      },
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF757575),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Menu Items Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.health_and_safety),
                      title: const Text('Health Band'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Healthband()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.message),
                      title: const Text('Message'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Message()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: const Text('Daily Goals'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DailyGoals()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.report),
                      title: const Text('Health Report'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HealthReport()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Setting'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Setting()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Log Out Section
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () {
                    // Handle log out
                    _signOut();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          !_showIndicator
              ? const HomePageContent()
              : widgetOptions.elementAt(_selectedIndex),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.69),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFA4A5FF)), // Change this color as needed
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          if (_showIndicator)
          // Positioned indicator
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width /
                  4 *
                  _selectedIndex, // Adjust position based on selected index
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4A5FF),
                  border: Border.all(
                    color: const Color(0xFFA4A5FF),
                    width: 7.5,
                  ),
                ),
              ),
            ),
          NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 8,
                  height: 1.4,
                ),
              ),
              indicatorColor: Colors.transparent,
            ),
            child: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 75,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/medicine_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Medication\nManagement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/managePrescription_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Prescription\nManagement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image:
                        AssetImage('assets/images/consultation_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Consultation\nAppointment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/community_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Community\nHub',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
              ],
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Quick Consult Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset in x and y direction
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "We will assign quick\nand best doctor",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA4A5FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Quick Consult",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Ongoing Medication
            const Text(
              "Ongoing Medication",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "-- No ongoing medication --",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Upcoming Appointment
            const Text(
              "Upcoming Appointment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/doctor.png'), // Replace with actual image asset
                ),
                title: const Text("Dr. Afna Khan"),
                subtitle: const Text("Skin Specialist | Hospital 123"),
                trailing: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text("4.9"),
                  ],
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFA4A5FF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset in x and y direction
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: const Center(
                child: Text(
                  "Today, 5:00 PM",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Pharmacy Nearby
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pharmacy Nearby",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See all"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 0, // remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 200, // Set the desired width
                            height: 125, // Set the desired height
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Set the desired border radius
                              child: Image.asset(
                                'assets/images/pharmacy1.jpg',
                                fit: BoxFit
                                    .cover, // Adjust the image to cover the box while maintaining its aspect ratio
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Pharmacy 456"),
                        ),
                        const Text("1.0 km | 4.8 reviews"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Card(
                    color: Colors.white,
                    elevation: 0, // remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 200, // Set the desired width
                            height: 125, // Set the desired height
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  12), // Set the desired border radius
                              child: Image.asset(
                                'assets/images/pharmacy2.png',
                                fit: BoxFit
                                    .cover, // Adjust the image to cover the box while maintaining its aspect ratio
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Pharmacy XYZ"),
                        ),
                        const Text("500 m | 4.8 reviews"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageNotLogin extends StatefulWidget {
  const HomePageNotLogin({Key? key}) : super(key: key);

  @override
  HomePageNotLoginState createState() => HomePageNotLoginState();
}

class HomePageNotLoginState extends State<HomePageNotLogin> {
  int _selectedIndex = 0; // Default selected index
  bool _showIndicator = false; // Indicator visibility

  static const List<Widget> widgetOptions = <Widget>[
    NotLogin(),
    Community(),
  ];

  void _topIconPressed(BuildContext context) {
    if (!_showIndicator) {
      // Collapsible sidebar here
      Scaffold.of(context).openDrawer(); // Open the drawer
    } else {
      setState(() {
        _showIndicator = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showIndicator = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF757575),
            height: 1.0,
          ),
        ),
        elevation: 0.0,
        toolbarHeight: 66.0,
        titleSpacing: 7.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: !_showIndicator
                ? const CircleAvatar(
              backgroundImage:
              AssetImage('assets/images/default_avatar.png'),
            )
                : const Icon(
              Icons.home,
              size: 35,
            ),
            onPressed: () {
              _topIconPressed(
                  context); // also switch between avatar and home icon
            },
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    isDense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                      color: Color(0xFF757575),
                    ),
                    hintText: 'Search Doctor, Medicine, Tests...',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF757575),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFF757575), width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top: 25.0),
          decoration: const BoxDecoration(
            color: Color(0xFFDAE2FF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // User Profile Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/default_avatar.png') // Just an alternative image, later on will do a homepage
                      // with exactly same design but with this default avatar image
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Guest',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Menu Items Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Text(
                              ' to see more features',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          !_showIndicator
              ? const HomePageContent()
              : widgetOptions.elementAt(_selectedIndex != 3 ? 0 : 1),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          if (_showIndicator)
          // Positioned indicator
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width /
                  4 *
                  _selectedIndex, // Adjust position based on selected index
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4A5FF),
                  border: Border.all(
                    color: const Color(0xFFA4A5FF),
                    width: 7.5,
                  ),
                ),
              ),
            ),
          NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 8,
                  height: 1.4,
                ),
              ),
              indicatorColor: Colors.transparent,
            ),
            child: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 75,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/medicine_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Medication\nManagement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/managePrescription_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Prescription\nManagement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image:
                        AssetImage('assets/images/consultation_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Consultation\nAppointment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/community_icon.png'),
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Community\nHub',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
              ],
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class NotLogin extends StatelessWidget {
  const NotLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text(
                'Click here',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Text(
              ' to login and see more',
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
