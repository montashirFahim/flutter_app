// lib/core/util/mock_data.dart
List<Map<String, dynamic>> mockUsers = [
  {
    'uid': 'user1',
    'email': 'test@example.com',
    'password': 'password123',
    'name': 'Test User',
    'username': 'testuser',
    'dob': '01/01/1990',
    'gender': 'Male',
  },
];

List<Map<String, dynamic>> mockPosts = [
  {
    'id': 'post1',
    'authorId': 'user1',
    'authorName': 'Test User',
    'content': 'This is a sample post!',
    'likes': 5,
    'isLiked': false,
    'comments': [
      {
        'authorId': 'user2',
        'authorName': 'Commenter',
        'content': 'Great post!',
      },
    ],
  },
  {
    'id': 'post2',
    'authorId': 'user1',
    'authorName': 'Test User',
    'content': 'Another post here.',
    'likes': 3,
    'isLiked': true,
    'comments': [],
  },
];
