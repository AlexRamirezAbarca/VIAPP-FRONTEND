import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
    String identification;
    String firstName;
    String lastName;
    String email;
    String userName;
    String urlPhoto;
    dynamic phone;
    dynamic birthDate;

    ProfileResponse({
        required this.identification,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.userName,
        required this.urlPhoto,
        required this.phone,
        required this.birthDate,
    });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        identification: json["identification"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userName: json["user_name"],
        urlPhoto: json["url_photo"],
        phone: json["phone"],
        birthDate: json["birth_date"],
    );

    Map<String, dynamic> toJson() => {
        "identification": identification,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_name": userName,
        "url_photo": urlPhoto,
        "phone": phone,
        "birth_date": birthDate,
    };
}
