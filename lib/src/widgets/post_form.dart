import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/src/models/post.dart';

class PostForm extends StatefulWidget {
  final Function(Post) onPost;

  const PostForm({super.key, required this.onPost});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = photo;
    });
  }
  
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  void _submitPost() {
    if (_imageFile != null) {
      final post = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: 'current_user',
        caption: _captionController.text,
        imageUrl: _imageFile!.path,
        timestamp: DateTime.now(),
        likes: 0,
        comments: [],
      );
      widget.onPost(post);
      _captionController.clear();
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (_imageFile == null)
            Container(
              height: 300,
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Choose from Gallery'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _takePhoto,
                      child: Text('Take a Photo'),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.image_not_supported, size: 80, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _imageFile = null;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _imageFile != null ? _submitPost : null,
                child: Text('Share'),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}