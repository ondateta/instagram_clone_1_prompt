class Post {
  final String id;
  final String username;
  final String caption;
  final String imageUrl;
  final DateTime timestamp;
  int likes;
  final List<Comment> comments;
  final String userProfileImageUrl;
  final String? location;

  Post({
    required this.id,
    required this.username,
    required this.caption,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.userProfileImageUrl = 'assets/profile_placeholder.jpg',
    this.location,
  });
}

class Comment {
  final String id;
  final String username;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.username,
    required this.text,
    required this.timestamp,
  });
}

class Story {
  final String id;
  final String username;
  final String imageUrl;
  final bool viewed;

  Story({
    required this.id,
    required this.username,
    required this.imageUrl,
    this.viewed = false,
  });
}