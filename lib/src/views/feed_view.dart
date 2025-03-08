import 'package:flutter/material.dart';
import 'package:template/src/models/post.dart';
import 'package:template/src/services/post_service.dart';
import 'package:template/src/widgets/story_row.dart';
import 'dart:io';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  List<Post> _posts = [];
  List<Story> _stories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _posts = PostService.instance.getPosts();
      _stories = PostService.instance.getStories();
    });
  }

  void _likePost(String postId) {
    PostService.instance.likePost(postId);
    setState(() {
      _posts = PostService.instance.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram', style: TextStyle(fontFamily: 'Billabong', fontSize: 30)),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData();
        },
        child: ListView(
          children: [
            StoryRow(stories: _stories),
            Divider(height: 1, thickness: 0.5),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return _PostItem(
                  post: _posts[index],
                  onLikePressed: () => _likePost(_posts[index].id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback onLikePressed;

  const _PostItem({
    Key? key,
    required this.post,
    required this.onLikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post.userProfileImageUrl),
          ),
          title: Text(post.username, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: post.location != null ? Text(post.location!) : null,
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            post.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: onLikePressed,
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.likes} likes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  children: [
                    TextSpan(
                      text: '${post.username} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: post.caption,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text(
                'View all ${post.comments.length} comments',
                style: TextStyle(color: Colors.grey[600]),
              ),
              if (post.comments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                      children: [
                        TextSpan(
                          text: '${post.comments.first.username} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: post.comments.first.text,
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 4),
              Text(
                '${_timeAgo(post.timestamp)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  String _timeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'just now';
    }
  }
}