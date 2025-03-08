import 'package:flutter/material.dart';
import 'package:template/src/models/post.dart';

class StoryRow extends StatelessWidget {
  final List<Story> stories;

  const StoryRow({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return _StoryItem(
            story: story,
            isCurrentUser: index == 0,
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final Story story;
  final bool isCurrentUser;

  const _StoryItem({
    Key? key,
    required this.story,
    this.isCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story.viewed
                  ? null
                  : LinearGradient(
                      colors: [Colors.purple, Colors.red, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            padding: EdgeInsets.all(2),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(story.imageUrl),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            isCurrentUser ? 'Your Story' : story.username,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}