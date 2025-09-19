import 'package:flutter/material.dart';
import 'package:nebula_app/models/video_post.dart';

class VideoGrid extends StatelessWidget {
  final List<VideoPost> items;
  const VideoGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, i) {
            final v = items[i];
            return Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(v.thumbnailUrl, fit: BoxFit.cover),
                  ),
                ),
                if (v.pinned)
                  Positioned(
                    left: 6, top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Pinned', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                  ),
                Positioned(
                  left: 8, bottom: 8,
                  child: Row(
                    children: [
                      const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 2),
                      Text('${v.views}K', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            );
          },
          childCount: items.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6, childAspectRatio: 9/16,
        ),
      ),
    );
  }
}
