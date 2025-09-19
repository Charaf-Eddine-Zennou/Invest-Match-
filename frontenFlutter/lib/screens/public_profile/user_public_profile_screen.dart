import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/models/video_post.dart';
import 'package:nebula_app/widgets/profile_public/public_profile_header.dart';
import 'package:nebula_app/widgets/profile_public/profile_action_bar.dart';
import 'package:nebula_app/widgets/profile_public/video_grid.dart';

class UserPublicProfileScreen extends StatefulWidget {
  final UserProfile profile;
  const UserPublicProfileScreen({super.key, required this.profile});

  @override
  State<UserPublicProfileScreen> createState() => _UserPublicProfileScreenState();
}

class _UserPublicProfileScreenState extends State<UserPublicProfileScreen> {
  bool following = false;

  final _videos = List.generate(9, (i) => VideoPost(
    id: 'u$i',
    thumbnailUrl: 'https://picsum.photos/seed/user$i/500/850',
    views: 12 + i * 4,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PublicProfileHeader(profile: widget.profile)),
          SliverToBoxAdapter(
            child: ProfileActionBar(
              isFollowing: following,
              onToggleFollow: () => setState(() => following = !following),
              onMessage: () {}, onMore: () {},
            ),
          ),
          VideoGrid(items: _videos),
        ],
      ),
    );
  }
}
