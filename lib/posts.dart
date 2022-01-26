class Posts {
  final String id;
  final String user_id;
  final String title;
  final String body;

  const Posts({
    required this.id,
    required this.user_id,
    required this.title,
    required this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
