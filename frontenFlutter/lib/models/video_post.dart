class VideoPost {
  final String id;
  final String thumbnailUrl;
  final bool pinned;
  final int views;

  const VideoPost({
    required this.id,
    required this.thumbnailUrl,
    this.pinned = false,
    this.views = 0,
  });
}
