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
        title: const Text('Add Comment', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(
            labelText: 'Comment',
            labelStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.lightBlue[50],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue[400]!),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
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
            style: TextButton.styleFrom(backgroundColor: Colors.lightBlue[200]),
            child: const Text('Submit', style: TextStyle(color: Colors.black)),
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
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 111, 200, 241), // Sky blue
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.app_registration, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Menu',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.feed, color: Colors.black),
                    title: const Text(
                      'Feed',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/feed'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => context.read<AuthCubit>().logout(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.lightBlue[200],
                    title: const Text(
                      'Feed',
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.black),
                        onPressed: () => context.read<AuthCubit>().logout(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _postController,
                            decoration: InputDecoration(
                              labelText: 'Create a post',
                              labelStyle: const TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.lightBlue[50],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlue[200]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlue[400]!,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[200],
                          ),
                          onPressed: () => _createPost(context),
                          child: const Text(
                            'Post',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<FeedCubit, FeedStates>(
                      builder: (context, state) {
                        if (state is FeedLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (state is FeedError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }
                        if (state is FeedLoaded) {
                          return ListView.builder(
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) {
                              final post = state.posts[index];
                              return Card(
                                color: Colors.lightBlue[200],
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.authorName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        post.content,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              post.isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: post.isLiked
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                            onPressed: () => context
                                                .read<FeedCubit>()
                                                .toggleLike(post.id),
                                          ),
                                          Text(
                                            '${post.likes}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.comment,
                                              color: Colors.black,
                                            ),
                                            onPressed: () =>
                                                _addComment(context, post.id),
                                          ),
                                          Text(
                                            '${post.comments.length}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (post.comments.isNotEmpty) ...[
                                        const Divider(color: Colors.black26),
                                        ...post.comments.map(
                                          (comment) => Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              '${comment['authorName']}: ${comment['content']}',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
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
                        return const Center(
                          child: Text(
                            'No posts available',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
