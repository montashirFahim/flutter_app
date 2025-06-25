// lib/features/feed/data/repositories/mock_feed_repo.dart
import 'package:app_1/core/util/mock_data.dart';
import 'package:app_1/features/feed/data/models/post_model.dart';
import 'package:app_1/features/feed/domain/entities/post.dart';
import 'package:app_1/features/feed/domain/repositories/feed_repo.dart';
import 'package:uuid/uuid.dart';

class MockFeedRepo implements FeedRepo {
  @override
  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return mockPosts.map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<void> createPost(
    String content,
    String authorId,
    String authorName,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final newPost = PostModel(
      id: const Uuid().v4(),
      authorId: authorId,
      authorName: authorName,
      content: content,
    );
    mockPosts.add(newPost.toJson());
  }

  @override
  Future<void> toggleLike(String postId, String userId) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final postIndex = mockPosts.indexWhere((p) => p['id'] == postId);
    if (postIndex != -1) {
      final post = mockPosts[postIndex];
      final isLiked = post['isLiked'] == true;
      mockPosts[postIndex] = {
        ...post,
        'likes': isLiked ? post['likes'] - 1 : post['likes'] + 1,
        'isLiked': !isLiked,
      };
    }
  }

  @override
  Future<void> addComment(
    String postId,
    String content,
    String authorId,
    String authorName,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final postIndex = mockPosts.indexWhere((p) => p['id'] == postId);
    if (postIndex != -1) {
      final post = mockPosts[postIndex];
      final comments = List<Map<String, String>>.from(post['comments']);
      comments.add({
        'authorId': authorId,
        'authorName': authorName,
        'content': content,
      });
      mockPosts[postIndex] = {...post, 'comments': comments};
    }
  }
}
