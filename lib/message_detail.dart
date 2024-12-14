import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Implement navigation back
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0,
        title: const Row(
          mainAxisSize: MainAxisSize.min, // Minimize the space taken by the Row
          children: [
            CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/doctorconsultation2.jpg"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Lebron James',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Phone call icon

            Icon(Icons.phone, color: Color(0xFFA4A5FF)),
            SizedBox(width: 10),
            Icon(Icons.videocam, color: Color(0xFFA4A5FF)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Implement action
            },
          ),
        ],
        scrolledUnderElevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Message from Doctor
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Hi SK, how are you? I saw on Jungle that we have Dragonfly in common. 😊',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        Text('2:55 PM', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                // User Reply
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xAAAEC7FF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Haha truly! Nice to meet you Dr! What about a cup of coffee today evening? ☕',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('3:02 PM',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 5),
                            Icon(Icons.done_all, color: Colors.blue, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Another message from Doctor
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sure, let’s do it! 😊',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        Text('3:10 PM', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                // User Reply
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xAAAEC7FF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Great! I will write later the exact time and place. See you soon!',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('3:12 PM',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 5),
                            Icon(Icons.done_all, color: Colors.blue, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFFA4A5FF)),
                        onPressed: () {
                          // Send message action
                        },
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
