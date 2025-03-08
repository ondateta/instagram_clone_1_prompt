import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatelessWidget {
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final String username;
  final String displayName;
  final String bio;
  final String website;
  final String profileImageUrl;

  const ProfileHeader({
    Key? key,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    this.username = 'username',
    this.displayName = 'Display Name',
    this.bio = 'This is a bio description. Add a short description about yourself.',
    this.website = 'www.example.com',
    this.profileImageUrl = 'assets/profile_placeholder.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(profileImageUrl),
                backgroundColor: Colors.grey[300],
              ),
              Gap(24),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn(context, 'Posts', postsCount.toString()),
                    _buildStatColumn(context, 'Followers', _formatCount(followersCount)),
                    _buildStatColumn(context, 'Following', _formatCount(followingCount)),
                  ],
                ),
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
                displayName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gap(4),
              Text(bio),
              Gap(4),
              Text(
                website,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Edit Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(16),
        Divider(height: 1),
      ],
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gap(4),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}