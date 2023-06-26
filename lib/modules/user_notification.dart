class UserNotification {
  int id;
  String title;
  String description;

  UserNotification({
    required this.id,
    required this.title,
    required this.description,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
