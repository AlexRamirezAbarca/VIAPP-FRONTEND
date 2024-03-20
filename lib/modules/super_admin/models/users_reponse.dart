import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    final List<User> users;

    UserResponse({
        required this.users,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    final int id;
    final String firstName;
    final String lastName;
    final String email;
    final String userName;
    final int status;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.userName,
        required this.status,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userName: json["user_name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_name": userName,
        "status": status,
    };
}
