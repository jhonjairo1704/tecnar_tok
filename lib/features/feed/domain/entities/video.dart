class Video {
  final String id;
  final String url;
  final String username;
  final String caption;
  final int likes;
  final bool isLiked;

  Video({
    required this.id,
    required this.url,
    required this.username,
    required this.caption,
    required this.likes,
    this.isLiked = false,
  });

  Video copyWith({bool? isLiked, int? likes}) {
    return Video(
      id: id,
      url: url,
      username: username,
      caption: caption,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}