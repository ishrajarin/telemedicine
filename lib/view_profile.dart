import 'package:flutter/material.dart';
import 'package:tele_medicine/calender.dart';
import 'package:tele_medicine/medicalhistory.dart';
import 'home.dart';
import 'dart:io';
import 'edit_profile.dart';
import 'models/user.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  ViewProfileState createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {
  // Fetch ALL user details
  String? displayName = UserCredentials().displayName;
  String? profilePicUrl = UserCredentials().profilePicUrl;
  String? email = UserCredentials().email;
  String? address = UserCredentials().address;
  String? realName = UserCredentials().realName;
  String? nric = UserCredentials().nric;
  String? phoneNumber = UserCredentials().phoneNumber;
  int? age = UserCredentials().age;
  String? gender = UserCredentials().gender;
  double? height = UserCredentials().height;
  double? weight = UserCredentials().weight;

  bool get isProfileIncomplete {
    return email == null ||
        email!.isEmpty ||
        address == null ||
        address!.isEmpty ||
        realName == null ||
        realName!.isEmpty ||
        nric == null ||
        nric!.isEmpty ||
        phoneNumber == null ||
        phoneNumber!.isEmpty ||
        age == null ||
        age == 0.0 ||
        gender == null ||
        gender!.isEmpty ||
        height == null ||
        height == 0.0 ||
        weight == null ||
        weight == 0.0;
  }

  bool showAlert = false;

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
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Adjust spacing between items
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add margin to the left and right
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Icon(
                            Icons.arrow_back_ios), // Add your first button here
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add margin to the left and right
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        },
                        child: const Icon(
                            Icons.edit), // Add your second button here
                      ),
                    ),
                  ],
                ),
                // Profile Picture
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Back Button and Profile Picture with Username
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: profilePicUrl != null &&
                                  profilePicUrl!.isNotEmpty
                                  ? (profilePicUrl!.startsWith('http') ||
                                  profilePicUrl!.startsWith('https')
                                  ? NetworkImage(profilePicUrl!)
                                  : FileImage(File(profilePicUrl!)))
                              as ImageProvider
                                  : const AssetImage(
                                  'assets/images/default_avatar.png'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            displayName ??
                                "", // Replace with user's real username
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Personal Details Card
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Personal details",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildDetailRow("Name:", realName ?? "-"),
                                  _buildDetailRow("NRIC:", nric ?? "-"),
                                  _buildDetailRow(
                                      "Contact no.:", phoneNumber ?? "-"),
                                  _buildDetailRow("Email:", email ?? "-"),
                                  _buildDetailRow("Address:", address ?? "-"),
                                  _buildDetailRow(
                                      "Age:",
                                      (age == null || age == 0.0)
                                          ? ""
                                          : age.toString()),
                                  _buildDetailRow("Gender:", gender ?? "-"),
                                  _buildDetailRow(
                                      "Height:",
                                      (height == null || height == 0.0)
                                          ? ""
                                          : height.toString()),
                                  _buildDetailRow(
                                      "Weight:",
                                      (weight == null || weight == 0.0)
                                          ? ""
                                          : weight.toString()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Health Status, Calendar, Medical History Buttons
                          _buildOptionCard(
                            icon: Icons.favorite,
                            text: "Health Status",
                            onTap: () {
                              // Handle Health Status tap
                            },
                          ),
                          _buildOptionCard(
                            icon: Icons.calendar_today,
                            text: "Calendar",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Calendar()),
                              );
                            },
                          ),
                          _buildOptionCard(
                            icon: Icons.history,
                            text: "Medical History",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const MedicalHistory()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating alert box
          if (isProfileIncomplete)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please ",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: const Text(
                        "complete your profile",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          decoration: TextDecoration.underline, // underline
                          decorationColor: Colors.red, // underline color
                        ),
                      ),
                    ),
                    const Text(
                      " for more features...",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildDetailRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start, // Aligns children at the top
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      const SizedBox(width: 112), // Adds space between the title and value
      Flexible(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          overflow: TextOverflow.visible, // Allows text to wrap
        ),
      ),
    ],
  );
}

Widget _buildOptionCard(
    {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    ),
  );
}
