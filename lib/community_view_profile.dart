import 'package:flutter/material.dart';

class CommunityViewProfile extends StatelessWidget {
  final String username;
  final String handle;
  final String bio;
  final int followers;
  final int following;
  final String profilePhoto;

  const CommunityViewProfile({
    super.key,
    required this.username,
    required this.handle,
    required this.bio,
    required this.followers,
    required this.following,
    required this.profilePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profilePhoto),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (username == 'Josephine')
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 20,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    handle,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  if (handle == '@josephinejojo')
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 20,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '$followers',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('Followers'),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      '$following',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('Following'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 210, 180, 229),
                ),
                child: const Text('Follow'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'About Me:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'A health expert with a passion for heart disease.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Posts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const PostWidget(
              username: 'Josephine',
              handle: '@josephinejojo',
              caption: 'posted a video',
              title: 'IMPORTANCE OF TELEMEDICINE',
              description: 'Accessible; Anytime, Anywhere',
              likes: 10,
              comments: 2,
              isVideo: true,
              avatarImage: 'assets/images/josephine_avatar.png',
            ),
            const PostWidget(
              username: 'Josephine',
              handle: '@josephinejojo',
              caption: 'posted an article',
              title: 'Global Health Concerns',
              description:
              'Systematic Review of Major Cardiovascular Risk Factors',
              likes: 519,
              comments: 10,
              isVideo: false,
              avatarImage: 'assets/images/josephine_avatar.png',
            ),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String username;
  final String handle;
  final String caption;
  final String title;
  final String description;
  final int likes;
  final int comments;
  final bool isVideo;
  final String avatarImage;

  const PostWidget({
    Key? key,
    required this.username,
    required this.handle,
    required this.caption,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    required this.isVideo,
    required this.avatarImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(avatarImage),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        handle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            if (isVideo)
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      'assets/images/community_videocover.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned.fill(
                    child: Center(
                      child: Icon(Icons.play_circle_fill,
                          color: Colors.white, size: 50),
                    ),
                  ),
                ],
              ),
            if (!isVideo)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[800],
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              description,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.comment, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('$comments Comments'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.thumb_up, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('$likes Likes'),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.bookmark_border, color: Colors.grey),
                    SizedBox(width: 5),
                    Icon(Icons.share, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
