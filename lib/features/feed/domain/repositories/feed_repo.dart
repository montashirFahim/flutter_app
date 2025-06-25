// lib/features/feed/domain/repositories/feed_repo.dart
import 'package:app_1/features/feed/domain/entities/post.dart';

abstract class FeedRepo {
  Future<List<Post>> fetchPosts();
  Future<void> createPost(String content, String authorId, String authorName);
  Future<void> toggleLike(String postId, String userId);
  Future<void> addComment(
    String postId,
    String content,
    String authorId,
    String authorName,
  );
}
