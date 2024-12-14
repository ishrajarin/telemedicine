import 'package:flutter/material.dart';
import 'package:tele_medicine/home.dart';

// Main Widget
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rounded Edge Background
          Container(
            margin:
            const EdgeInsets.only(top: 35.0), // Set the top margin to 35
            decoration: BoxDecoration(
              color: const Color.fromARGB(174, 174, 199, 255),
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
                SizedBox(height: 20.0), // Add spacing from the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust spacing between items
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Icon(Icons.arrow_back_ios), // Add your first button here
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0), // Add some padding to move the text to the right
                        child: Text(
                          'Setting',
                          style: TextStyle(fontSize: 30.0), // Adjust text style as needed
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Icon(Icons.more_vert_rounded), // Add your second button here
                    ),
                  ],
                ),
                SizedBox(height: 20.0), // Add spacing between header and cards
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          // ListView of Cards
          Padding(
            padding: const EdgeInsets.only(top: 95.0), // Adjust the top padding to overlap with background
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the ListView
              child: ListView(
                children: const [
                  SettingSection(
                    sectionTitle: 'Preferences',
                    items: [
                      SettingItem(
                        title: 'Language',
                        icon: Icons.language,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0), // Space between sections
                  SettingSection(
                    sectionTitle: 'Help Center',
                    items: [
                      SettingItem(
                        title: 'Customer Support',
                        icon: Icons.support_agent_sharp,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0), // Space between sections
                  SettingSection(
                    sectionTitle: 'About',
                    items: [
                      SettingItem(
                        title: 'Software Information',
                        icon: Icons.info,
                      ),
                      SettingItem(
                        title: 'Privacy & Policy',
                        icon: Icons.privacy_tip,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  final String sectionTitle;
  final List<SettingItem> items;

  const SettingSection({
    required this.sectionTitle,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        ...items.map((item) => Column(
          children: [
            item,
            SizedBox(height: 10.0), // Space between items
          ],
        )),
      ],
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingItem({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 24.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            TextButton(
              onPressed: (){},
              child: Icon(Icons.arrow_forward_ios, size: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
