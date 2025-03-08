import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buildNotificationItem(context, index);
        },
      ),
    );
  }
  
  Widget _buildNotificationItem(BuildContext context, int index) {
    final randomType = index % 4;
    
    String text;
    IconData? icon;
    
    switch (randomType) {
      case 0:
        text = "user_${index} liked your photo";
        icon = Icons.favorite;
        break;
      case 1:
        text = "user_${index} commented: 'Great post!'";
        icon = Icons.comment;
        break;
      case 2:
        text = "user_${index} started following you";
        icon = Icons.person_add;
        break;
      case 3:
        text = "user_${index} mentioned you in a comment";
        icon = Icons.alternate_email;
        break;
      default:
        text = "New notification";
        icon = Icons.notifications;
    }
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.grey[700]),
      ),
      title: RichText(
        text: TextSpan(
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          children: [
            TextSpan(
              text: "user_${index} ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: text.substring(text.indexOf(' ') + 1),
            ),
          ],
        ),
      ),
      subtitle: Text("${(index + 1) * 5}m ago"),
      trailing: randomType < 2 ? Container(
        width: 40,
        height: 40,
        color: Colors.grey[300],
      ) : null,
    );
  }
}