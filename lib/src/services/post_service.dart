import 'package:template/src/models/post.dart';

class PostService {
  static final PostService _instance = PostService._internal();
  static PostService get instance => _instance;

  PostService._internal() {
    _initializeDummyData();
  }

  final List<Post> _posts = [];
  final List<Story> _stories = [];

  void _initializeDummyData() {
    _stories.addAll([
      Story(
        id: '1',
        username: 'your_story',
        imageUrl: 'assets/profile_placeholder.jpg',
      ),
      Story(
        id: '2',
        username: 'user_1',
        imageUrl: 'assets/profile_placeholder.jpg',
      ),
      Story(
        id: '3',
        username: 'user_2',
        imageUrl: 'assets/profile_placeholder.jpg',
      ),
      Story(
        id: '4',
        username: 'user_3',
        imageUrl: 'assets/profile_placeholder.jpg',
        viewed: true,
      ),
      Story(
        id: '5',
        username: 'user_4',
        imageUrl: 'assets/profile_placeholder.jpg',
      ),
      Story(
        id: '6',
        username: 'user_5',
        imageUrl: 'assets/profile_placeholder.jpg',
        viewed: true,
      ),
      Story(
        id: '7',
        username: 'user_6',
        imageUrl: 'assets/profile_placeholder.jpg',
      ),
    ]);

    for (int i = 1; i <= 5; i++) {
      _posts.add(
        Post(
          id: i.toString(),
          username: 'user_$i',
          caption: 'This is a sample post caption for post $i. #instagram #clone #flutter',
          imageUrl: 'assets/post_$i.jpg',
          timestamp: DateTime.now().subtract(Duration(hours: i * 2)),
          likes: 100 + (i * 25),
          comments: _generateDummyComments(i),
          location: i % 2 == 0 ? 'New York, NY' : null,
        ),
      );
    }
  }

  List<Comment> _generateDummyComments(int postId) {
    List<Comment> comments = [];
    final int commentCount = 2 + (postId % 3);
    
    for (int i = 1; i <= commentCount; i++) {
      comments.add(
        Comment(
          id: '$postId-$i',
          username: 'commenter_$i',
          text: 'This is comment $i on post $postId! Looking great! 👍',
          timestamp: DateTime.now().subtract(Duration(hours: i)),
        ),
      );
    }
    
    return comments;
  }

  List<Post> getPosts() {
    return List.unmodifiable(_posts);
  }

  List<Story> getStories() {
    return List.unmodifiable(_stories);
  }

  void addPost(Post post) {
    _posts.add(post);
  }

  void likePost(String postId) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      _posts[postIndex].likes++;
    }
  }

  void addComment(String postId, Comment comment) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      _posts[postIndex].comments.add(comment);
    }
  }
}