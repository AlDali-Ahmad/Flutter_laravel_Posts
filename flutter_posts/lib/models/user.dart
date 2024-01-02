class User {
  late int id;
  late String name;
  late String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'],
     name: json['name'], 
     email: json['email']);
  }
}
