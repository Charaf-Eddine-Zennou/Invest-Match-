import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/models/video_post.dart';
import 'package:nebula_app/widgets/profile_public/public_profile_header.dart';
import 'package:nebula_app/widgets/profile_public/profile_action_bar.dart';
import 'package:nebula_app/widgets/profile_public/video_grid.dart';

class PublicProfileScreen extends StatefulWidget {
  final UserProfile profile;
  const PublicProfileScreen({super.key, required this.profile});

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  bool following = false;

  // fake videos
  late final List<VideoPost> _videos = List.generate(12, (i) => VideoPost(
    id: 'v$i',
    thumbnailUrl: 'https://picsum.photos/seed/p$i/400/700',
    pinned: i < 3 && i % 2 == 0,
    views: 20 + i * 3,
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
          // Pour l’instant une seule grille "Vidéos"
          VideoGrid(items: _videos),
        ],
      ),
    );
  }
}
