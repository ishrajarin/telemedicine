import 'package:flutter/material.dart';
import 'package:tele_medicine/firebase_auth_check.dart';

class RateOrder extends StatefulWidget {
  const RateOrder({Key? key}) : super(key: key);
  @override
  RateOrderState createState() => RateOrderState();
}

class RateOrderState extends State<RateOrder> {
  int _selectedRating = 0;

  // Define an array of feedback messages
  final List<String> feedbackMessages = [
    'Your feedback is anonymous. Please leave a feedback to help us improve.',
    'We\'re sorry to hear that you\'re not satisfied. Your feedback will help us make things right.', // 1 star
    'Thank you for your feedback. We\'re committed to improving your experience.', // 2 stars
    'Thank you for your feedback. We hope to do better next time.', // 3 stars
    'Your feedback helps us improve! We appreciate your support.', // 4 stars
    'Thank you for the great rating! We\'re glad you had a positive experience.', // 5 stars
  ];

  void _onStarPressed(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FirebaseAuthCheck()), // Replace NewPage with your target page
                  (Route<dynamic> route) => false,
            );
          },
        ),
        scrolledUnderElevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(), // Push content down
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Rate your order',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // 5 stars to be rated
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < _selectedRating
                              ? Colors.yellow[800]
                              : Colors.grey[200],
                        ),
                        onPressed: () => _onStarPressed(index + 1),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0), // Add horizontal padding
                    child: Text(
                      _selectedRating > 0 &&
                          _selectedRating <= feedbackMessages.length
                          ? feedbackMessages[_selectedRating]
                          : feedbackMessages[0],
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFF757575)),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            // Add your new element here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Your button action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA4A5FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Submit Feedback',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                      height: 8), // Add some space between the buttons
                  ElevatedButton(
                    onPressed: () {
                      // Your button action here
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FirebaseAuthCheck()), // Replace NewPage with your target page
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                    ),
                    child: const Text('Next Time',
                        style: TextStyle(color: Colors.grey)),
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
