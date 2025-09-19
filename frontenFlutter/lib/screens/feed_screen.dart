import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/feed.dart';
import '../screens/subscreens/search_screen_feed.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Feed(),
          Positioned(
            left: 0, right: 0, top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 34,
                      child: Image.asset("assets/images/fundly_logo.png"),
                    ),
                    GestureDetector(
                      onTap: () => pushPeerSlide(context, SearchScreenFeed()),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(Icons.search, color: Colors.white, size: 32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
