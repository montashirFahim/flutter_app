// lib/features/feed/presentation/cubit/feed_states.dart
import 'package:app_1/features/feed/domain/entities/post.dart';

abstract class FeedStates {}

class FeedInitial extends FeedStates {}

class FeedLoading extends FeedStates {}

class FeedLoaded extends FeedStates {
  final List<Post> posts;
  FeedLoaded(this.posts);
}

class FeedError extends FeedStates {
  final String message;
  FeedError(this.message);
}
