import 'package:flutter/material.dart';
import 'package:template/src/models/post.dart';
import 'package:template/src/services/post_service.dart';
import 'package:template/src/widgets/profile_header.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _posts = PostService.instance.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('username'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(
                child: ProfileHeader(
                  postsCount: _posts.length,
                  followersCount: 1240,
                  followingCount: 348,
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.bookmark_border)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPostsGrid(),
                    _buildSavedGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
          },
          child: Image.asset(
            _posts[index].imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[(index % 3 + 1) * 100],
              child: Center(
                child: Icon(Icons.image, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[(index % 3 + 1) * 200],
          child: Center(
            child: Icon(Icons.bookmark, color: Colors.white),
          ),
        );
      },
    );
  }
}