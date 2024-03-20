
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    User user;
    String token;

    LoginResponse({
        required this.user,
        required this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    int id;
    String firstName;
    String lastName;
    String email;
    String userName;
    int superUser;
    String identification;
    int status;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.userName,
        required this.superUser,
        required this.identification,
        required this.status,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userName: json["user_name"],
        superUser: json["super_user"],
        identification: json["identification"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_name": userName,
        "super_user": superUser,
        "identification": identification,
        "status": status,
    };
}
