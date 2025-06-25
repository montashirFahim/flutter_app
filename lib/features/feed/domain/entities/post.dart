// lib/features/feed/domain/entities/post.dart
class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String content;
  final int likes;
  final bool isLiked;
  final List<Map<String, String>> comments;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    this.likes = 0,
    this.isLiked = false,
    this.comments = const [],
  });

  Post copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? content,
    int? likes,
    bool? isLiked,
    List<Map<String, String>>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'likes': likes,
      'isLiked': isLiked,
      'comments': comments,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      content: json['content'],
      likes: json['likes'],
      isLiked: json['isLiked'],
      comments: List<Map<String, String>>.from(json['comments']),
    );
  }
}
