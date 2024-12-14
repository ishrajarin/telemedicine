import 'package:flutter/material.dart';

// Main Widget
class DailyGoals extends StatelessWidget {
  const DailyGoals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Preload images
    precacheImage(const AssetImage('assets/images/water.jpg'), context);
    precacheImage(const AssetImage('assets/images/carrot.jpg'), context);
    precacheImage(const AssetImage('assets/images/meditation.jpg'), context);
    precacheImage(const AssetImage('assets/images/skincare.jpg'), context);
    precacheImage(const AssetImage('assets/images/dumbbell.jpg'), context);

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
                          Navigator.pop(context);
                        },
                        child: const Icon(
                            Icons.arrow_back_ios), // Add your first button here
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Text(
                          'Daily Goals',
                          style: TextStyle(
                              fontSize: 30.0), // Adjust text style as needed
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add margin to the left and right
                      child: TextButton(
                        onPressed: () {},
                        child: const Icon(Icons
                            .more_vert_rounded), // Add your second button here
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 20.0), // Add spacing between header and cards
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      const CustomCard(
                        title: 'Water Intake',
                        description: 'Sufficient water intake',
                        imagePath: 'assets/images/water.jpg',
                      ),
                      const SizedBox(height: 20.0),
                      const CustomCard(
                        title: 'Eat 3 Meals',
                        description: 'Eat good food',
                        imagePath: 'assets/images/carrot.jpg',
                      ),
                      const SizedBox(height: 20.0),
                      const CustomCard(
                        title: 'Meditate For 5 MIN',
                        description: 'Calm your mind',
                        imagePath: 'assets/images/meditation.jpg',
                      ),
                      const SizedBox(height: 20.0),
                      const CustomCard(
                        title: 'Evening Skincare',
                        description: 'Always 18 years old',
                        imagePath: 'assets/images/skincare.jpg',
                      ),
                      const SizedBox(height: 20.0),
                      const CustomCard(
                        title: '30 MIN workout',
                        description: 'Keep fit',
                        imagePath: 'assets/images/dumbbell.jpg',
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add action for the "Add" button
                          },
                          child: const Text('Add'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
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

// Custom Card Widget
class CustomCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const CustomCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set the default color to white
      elevation: 8.0, // Add elevation to create a shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              widget.imagePath,
              width: 50.0, // Adjust the width of the image as needed
              height: 50.0, // Adjust the height of the image as needed
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0), // Spacing between the image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
