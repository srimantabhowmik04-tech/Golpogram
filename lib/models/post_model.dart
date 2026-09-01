class PostItem {
  final String id;
  final String author;
  final String time;
  final String text;
  int likes;
  bool isLiked;
  final List<String> comments;

  PostItem({
    required this.id,
    required this.author,
    required this.time,
    required this.text,
    this.likes = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}
