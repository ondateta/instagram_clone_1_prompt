import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/src/models/post.dart';
import 'package:template/src/services/post_service.dart';
import 'package:template/src/widgets/post_form.dart';
import 'package:go_router/go_router.dart';
class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: PostForm(
        onPost: (Post post) {
          PostService.instance.addPost(post);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post created successfully!')),
          );
          context.go('/feed');
        },
      ),
    );
  }
}