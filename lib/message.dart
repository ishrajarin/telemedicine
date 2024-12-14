import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Round-edged background
          Container(
            margin: const EdgeInsets.only(top: 35.0), // Set top margin
            decoration: BoxDecoration(
              color: const Color.fromARGB(174, 174, 199, 255),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            height: MediaQuery.of(context).size.height, // Set height to screen height
            child: Column(
              children: [
                const SizedBox(height: 20.0), // Add spacing from the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust spacing between items
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios), // Add your first button here
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0), // Add some padding to move the text to the right
                        child: Text(
                          'Message',
                          style: TextStyle(fontSize: 30.0), // Adjust text style as needed
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.more_vert_rounded), // Add your second button here
                    ),
                  ],
                ),
                const SizedBox(height: 20.0), // Add spacing between header and cards

                // Wrap CustomCard with Container to set width
                Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Set width to 90% of screen width
                  child: CustomCard(
                    imageUrl: 'assets/images/doctorconsultation3.jpg', // Add your image path here
                    title: 'Dr. Jane Smith',
                    subtitle1: '011-2134 9824',
                    subtitle2: 'Reminder for your appointment Mr. Jason',
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20.0), // Add spacing between cards
                Container(
                  width: MediaQuery.of(context).size.width * 0.9, // Set width to 90% of screen width
                  child: CustomCard(
                    imageUrl: 'assets/images/doctorconsultation2.jpg', // Add your image path here
                    title: 'Dr. Lebron James',
                    subtitle1: '011-792 3699',
                    subtitle2: 'Get well soon Mr. Jason!',
                    onTap: () {},
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

// CustomCard class to create the card with a row, picture, and text
class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final VoidCallback onTap; // Callback function for onTap event

  const CustomCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.onTap, // Added onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Handles the tap event
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Making the image square
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0), // Optional: Rounded corners for the image
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover, // Ensures the image fits within the square
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0), // Add spacing between text lines
                  Text(
                    subtitle1,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 5.0), // Add spacing between text lines
                  Text(
                    subtitle2,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
