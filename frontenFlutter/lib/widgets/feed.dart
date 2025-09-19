import 'package:flutter/material.dart';
import 'feed_post.dart';
import '../screens/subscreens/company_profile_screen.dart';
import '../main.dart';
import 'package:nebula_app/services/demo_entities.dart';
import 'package:nebula_app/utils/nav_public_profile.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<Map<String, dynamic>> posts = [
    {
      "companyName": "Green Future Solutions",
      "profilePicPath": "assets/images/company_placeholder.png",
      "caption": "Pionnier des énergies renouvelables 🌱 pour un avenir durable - rejoignez notre mission ! C'est vraiment long pour tester la pagination de la caption.",
      "media": ["assets/images/company_placeholder.png"],
      "isFollowing": false,
    },
    {
      "companyName": "Green Future Solutions",
      "profilePicPath": "assets/images/company_placeholder.png",
      "caption": "Pionnier des énergies renouvelables 🌱 pour un avenir durable - rejoignez notre mission ! C'est vraiment long pour tester la pagination de la caption.",
      "media": ["assets/images/company_placeholder.png"],
      "isFollowing": false,
    },
    {
      "companyName": "FinTech Innovators",
      "profilePicPath": "assets/images/company_placeholder.png",
      "caption": "Réinventer la finance au service des PME. Découvrez notre dernier produit...",
      "media": ["assets/images/company_placeholder.png"],
      "isFollowing": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (_, i) {
        final p = posts[i];
        return FeedPost(
          companyName: p["companyName"],
          profilePicPath: p["profilePicPath"],
          caption: p["caption"],
          media: List<String>.from(p["media"] ?? []),
          isFollowing: p["isFollowing"],
          onProfileTap: () => openPublicProfile(context, greenFuture)
        );
      },
    );
  }
}
