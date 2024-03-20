import 'dart:convert';

TokenChangePassword tokenChangePasswordFromJson(String str) => TokenChangePassword.fromJson(json.decode(str));

String tokenChangePasswordToJson(TokenChangePassword data) => json.encode(data.toJson());

class TokenChangePassword {
    String token;

    TokenChangePassword({
        required this.token,
    });

    factory TokenChangePassword.fromJson(Map<String, dynamic> json) => TokenChangePassword(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };

    @override
    String toString() {
        return 'TokenChangePassword{token: $token}';
    }
    
}
