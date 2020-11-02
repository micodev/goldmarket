class User {
  String name;
  String username;
  String role;

  User({this.name, this.username, this.role});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['role'] = this.role;
    return data;
  }
}
