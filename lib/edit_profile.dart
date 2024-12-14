import 'package:flutter/material.dart';
import 'dart:io';
import 'view_profile.dart';
import '/models/user.dart';
import 'map_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  // Create user instance
  UserCredentials user = UserCredentials();

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

  late TextEditingController displayNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController realNameController;
  late TextEditingController nricController;
  late TextEditingController phoneNumberController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    displayNameController = TextEditingController(text: displayName ?? "");
    emailController = TextEditingController(text: email ?? "");
    realNameController = TextEditingController(text: realName ?? "");
    nricController = TextEditingController(text: nric ?? "");
    addressController = TextEditingController(text: address ?? "");
    phoneNumberController = TextEditingController(text: phoneNumber ?? "");
    ageController = TextEditingController(
        text: (age == null || age == 0) ? "" : age.toString());
    genderController = TextEditingController(text: gender ?? "");
    heightController = TextEditingController(
        text: (height == null || height == 0.0) ? "" : height.toString());
    weightController = TextEditingController(
        text: (weight == null || weight == 0.0) ? "" : weight.toString());
  }

  @override
  void dispose() {
    // Dispose controllers
    displayNameController.dispose();
    emailController.dispose();
    realNameController.dispose();
    nricController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _openMapPicker() async {
    LatLng? initialPosition;
    // Logic to get the initial position if available
    String address = addressController.text;

    // Convert address to coordinates
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        initialPosition =
            LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print("Error converting address to coordinates: $e");
    }

    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPicker(
            onLocationPicked: (address) {
              setState(() {
                addressController.text = address;
              });
            },
            initialPosition: initialPosition,
          ),
        ),
      );
    }
  }

  // Update
  void updateAll() async {
    // Update UserCredentials singleton with new values
    user.updateUser(
      displayName: displayNameController.text,
      profilePicUrl: profilePicUrl,
      email: emailController.text,
      realName: realNameController.text,
      nric: nricController.text,
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      age: int.tryParse(ageController.text) ?? 0,
      gender: genderController.text,
      height: double.tryParse(heightController.text) ?? 0.0,
      weight: double.tryParse(weightController.text) ?? 0.0,
    );
    await user.saveToPreferences();
  }

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
                          // Save preference before going back
                          updateAll();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewProfile()),
                                (Route<dynamic> route) => route.isFirst,
                          );
                        },
                        child: const Icon(
                            Icons.arrow_back_ios), // Add your first button here
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
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image != null) {
                                  setState(() {
                                    profilePicUrl = image
                                        .path; // Update profilePicUrl with the selected image path
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                profilePicUrl != null &&
                                    profilePicUrl!.isNotEmpty
                                    ? (profilePicUrl!.startsWith('http') ||
                                    profilePicUrl!
                                        .startsWith('https')
                                    ? NetworkImage(profilePicUrl!)
                                    : FileImage(
                                    File(profilePicUrl!)))
                                as ImageProvider
                                    : const AssetImage(
                                    'assets/images/default_avatar.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                setState(() {
                                  profilePicUrl = image
                                      .path; // Update profilePicUrl with the selected image path
                                });
                              }
                            },
                            child: const Text(
                              'Change Picture',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: displayNameController,
                                    label: "Username",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: emailController,
                                    label: "Email",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: realNameController,
                                    label: "Real Name",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: nricController,
                                    label: "NRIC as per IC",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: phoneNumberController,
                                    label: "Contact Number",
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: addressController,
                                    decoration: InputDecoration(
                                      labelText: "Address",
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.location_on),
                                        onPressed: _openMapPicker,
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: ageController,
                                    label: "Age",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: genderController,
                                    label: "Gender",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: heightController,
                                    label: "Height",
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: weightController,
                                    label: "Weight",
                                  ),
                                  const SizedBox(height: 20),
                                  // Confirm change button
                                  ElevatedButton(
                                    onPressed: () {
                                      // Save preference before going back
                                      updateAll();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const ViewProfile()),
                                            (Route<dynamic> route) => route.isFirst,
                                      );
                                    },
                                    child: const Text('Confirm Changes'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
