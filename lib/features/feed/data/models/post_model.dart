// lib/features/feed/data/models/post_model.dart
import 'package:app_1/features/feed/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.content,
    super.likes,
    super.isLiked,
    super.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      content: json['content'],
      likes: json['likes'],
      isLiked: json['isLiked'],
      comments: List<Map<String, String>>.from(json['comments']),
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
}
