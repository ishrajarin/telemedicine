import 'package:flutter/material.dart';

class CommunityNotification extends StatelessWidget {
  const CommunityNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text('HB')),
              title: Text('Harry Baker'),
              subtitle: Text('Posted an article About Telemedicine'),
              trailing: Text('12 mins ago'),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text('ZWY')),
              title: Text('Zhang Wan Yi'),
              subtitle: Text('Shared your post'),
              trailing: Icon(Icons.share),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text('YY')),
              title: Text('Yang Yang'),
              subtitle: Text(
                  'Replied to you.... \nThe normal heart rate varies by age and activity level...'),
              trailing: Icon(Icons.reply),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text('SJ')),
              title: Text('Steve and others'),
              subtitle: Text(
                  'added comments on Farita Smith - Importance of Telemedicine'),
              trailing: Icon(Icons.comment),
            ),
          ),
        ],
      ),
    );
  }
}
