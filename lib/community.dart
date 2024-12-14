import 'package:flutter/material.dart';
import 'community_profile_page.dart';
import 'community_view_profile.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommunityProfilePage(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/Loopy.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                PostWidget(
                  username: 'Josephine',
                  handle: '@josephiejojo',
                  caption: 'posted an article',
                  title: 'Global Health Concerns',
                  description:
                  'Systematic Review of Major Cardiovascular Risk Factors',
                  likes: 519,
                  comments: 10,
                  isVideo: false,
                  bio:
                  'Josephine is a health expert with a passion for global health.',
                  followers: 520,
                  following: 1314,
                  healthTips: [
                    'Eat Healthy',
                    'Exercise Regularly',
                    'Sleep Well'
                  ],
                  avatarImage: 'assets/images/josephine_avatar.png',
                ),
                PostWidget(
                  username: 'Farita Smith',
                  handle: '@SmithFa',
                  caption: 'posted a video',
                  title: 'IMPORTANCE OF TELEMEDICINE',
                  description: 'Accessible; Anytime, Anywhere',
                  likes: 10,
                  comments: 2,
                  isVideo: true,
                  bio:
                  'Farita is a telemedicine specialist focused on digital healthcare.',
                  followers: 300,
                  following: 900,
                  healthTips: [
                    'Use Telemedicine',
                    'Stay Informed',
                    'Keep Active'
                  ],
                  avatarImage: 'assets/images/farita_avatar.png',
                ),
              ],
            ),
          ),
        ],
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
  final String bio;
  final int followers;
  final int following;
  final List<String> healthTips;
  final String avatarImage;

  const PostWidget({
    super.key,
    required this.username,
    required this.handle,
    required this.caption,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    required this.isVideo,
    required this.bio,
    required this.followers,
    required this.following,
    required this.healthTips,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityViewProfile(
                      username: username,
                      handle: handle,
                      bio: bio,
                      followers: followers,
                      following: following,
                      profilePhoto: avatarImage,
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: AssetImage(avatarImage),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(handle, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(caption, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  isVideo ? buildVideoPost() : buildArticlePost(),
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
          ],
        ),
      ),
    );
  }

  Widget buildArticlePost() {
    return Container(
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
    );
  }

  Widget buildVideoPost() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.black),
                  onPressed: () {},
                ),
                const Text(
                  '00:00 / 03:00',
                  style: TextStyle(color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
