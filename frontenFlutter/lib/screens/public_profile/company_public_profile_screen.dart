import 'package:flutter/material.dart';
import 'package:nebula_app/models/user_profile_model.dart';
import 'package:nebula_app/models/video_post.dart';
import 'package:nebula_app/widgets/profile_public/public_profile_header.dart';
import 'package:nebula_app/widgets/profile_public/profile_action_bar.dart';
import 'package:nebula_app/widgets/profile_public/video_grid.dart';

class CompanyPublicProfileScreen extends StatefulWidget {
  final UserProfile profile;
  const CompanyPublicProfileScreen({super.key, required this.profile});

  @override
  State<CompanyPublicProfileScreen> createState() => _CompanyPublicProfileScreenState();
}

class _CompanyPublicProfileScreenState extends State<CompanyPublicProfileScreen>
    with TickerProviderStateMixin {
  bool following = false;
  late final TabController _tabs = TabController(length: 2, vsync: this);

  // Fake videos
  final _videos = List.generate(12, (i) => VideoPost(
    id: 'c$i',
    thumbnailUrl: 'https://picsum.photos/seed/company$i/500/850',
    pinned: i < 3, views: 30 + i * 5,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text(
              widget.profile.companyName ?? widget.profile.username,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SliverToBoxAdapter(child: PublicProfileHeader(profile: widget.profile)),
          SliverToBoxAdapter(
            child: ProfileActionBar(
              isFollowing: following,
              onToggleFollow: () => setState(() => following = !following),
              onMessage: () {}, onMore: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabs,
              tabs: const [Tab(text: 'Vidéos'), Tab(text: 'À propos')],
              labelColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            CustomScrollView(slivers: [VideoGrid(items: _videos)]),
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                ListTile(title: const Text('Secteurs'), subtitle: Text(widget.profile.sectors.join(' · '))),
                if ((widget.profile.address ?? '').isNotEmpty)
                  ListTile(title: const Text('Adresse'), subtitle: Text(widget.profile.address!)),
                if ((widget.profile.domain ?? '').isNotEmpty)
                  ListTile(title: const Text('Site web'), subtitle: Text(widget.profile.domain!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarHeader extends SliverPersistentHeaderDelegate {
  _TabBarHeader(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeader oldDelegate) => false;
}

