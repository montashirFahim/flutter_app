// lib/features/feed/presentation/cubit/feed_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/feed/domain/repositories/feed_repo.dart';
import 'feed_states.dart';

class FeedCubit extends Cubit<FeedStates> {
  final FeedRepo feedRepo;
  final AuthCubit authCubit;

  FeedCubit({required this.feedRepo, required this.authCubit})
    : super(FeedInitial());

  Future<void> fetchPosts() async {
    emit(FeedLoading());
    try {
      final posts = await feedRepo.fetchPosts();
      emit(FeedLoaded(posts));
    } catch (e) {
      emit(FeedError("Failed to load posts: $e"));
    }
  }

  Future<void> createPost(String content) async {
    final user = authCubit.getCurrentUser();
    if (user != null) {
      try {
        await feedRepo.createPost(content, user.uid, user.name);
        await fetchPosts();
      } catch (e) {
        emit(FeedError("Failed to create post: $e"));
      }
    } else {
      emit(FeedError("User not authenticated"));
    }
  }

  Future<void> toggleLike(String postId) async {
    final user = authCubit.getCurrentUser();
    if (user != null) {
      try {
        await feedRepo.toggleLike(postId, user.uid);
        await fetchPosts();
      } catch (e) {
        emit(FeedError("Failed to toggle like: $e"));
      }
    } else {
      emit(FeedError("User not authenticated"));
    }
  }

  Future<void> addComment(String postId, String content) async {
    final user = authCubit.getCurrentUser();
    if (user != null) {
      try {
        await feedRepo.addComment(postId, content, user.uid, user.name);
        await fetchPosts();
      } catch (e) {
        emit(FeedError("Failed to add comment: $e"));
      }
    } else {
      emit(FeedError("User not authenticated"));
    }
  }
}
