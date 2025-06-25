// lib/features/feed/presentation/pages/feed_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_states.dart';
import 'package:app_1/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:app_1/features/feed/presentation/cubit/feed_states.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FeedCubit>().fetchPosts();
  }

  void _createPost(BuildContext context) {
    if (_postController.text.trim().isNotEmpty) {
      context.read<FeedCubit>().createPost(_postController.text.trim());
      _postController.clear();
    }
  }

  void _addComment(BuildContext context, String postId) {
    final commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(labelText: 'Comment'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (commentController.text.trim().isNotEmpty) {
                context.read<FeedCubit>().addComment(
                  postId,
                  commentController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<AuthCubit>().logout(),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        labelText: 'Create a post',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _createPost(context),
                    child: const Text('Post'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<FeedCubit, FeedStates>(
                builder: (context, state) {
                  if (state is FeedLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FeedError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is FeedLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.authorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(post.content),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        post.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: post.isLiked ? Colors.red : null,
                                      ),
                                      onPressed: () => context
                                          .read<FeedCubit>()
                                          .toggleLike(post.id),
                                    ),
                                    Text('${post.likes}'),
                                    const SizedBox(width: 16),
                                    IconButton(
                                      icon: const Icon(Icons.comment),
                                      onPressed: () =>
                                          _addComment(context, post.id),
                                    ),
                                    Text('${post.comments.length}'),
                                  ],
                                ),
                                if (post.comments.isNotEmpty) ...[
                                  const Divider(),
                                  ...post.comments.map(
                                    (comment) => Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${comment['authorName']}: ${comment['content']}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No posts available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}
