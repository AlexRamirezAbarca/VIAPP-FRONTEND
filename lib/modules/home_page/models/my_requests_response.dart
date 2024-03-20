import 'dart:convert';

MyRequests myRequestsFromJson(String str) => MyRequests.fromJson(json.decode(str));

String myRequestsToJson(MyRequests data) => json.encode(data.toJson());

class MyRequests {
    List<MyRequest> myRequests;

    MyRequests({
        required this.myRequests,
    });

    factory MyRequests.fromJson(Map<String, dynamic> json) => MyRequests(
        myRequests: List<MyRequest>.from(json["requests"].map((x) => MyRequest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(myRequests.map((x) => x.toJson())),
    };
}

class MyRequest {
    int id;
    String fullName;
    String nameRequest;
    String code;
    String nameStatus;
    String colorStatus;

    MyRequest({
        required this.id,
        required this.fullName,
        required this.nameRequest,
        required this.code,
        required this.nameStatus,
        required this.colorStatus,
    });

    factory MyRequest.fromJson(Map<String, dynamic> json) => MyRequest(
        id: json["id"],
        fullName: json["full_name"],
        nameRequest: json["name_request"],
        code: json["code"],
        nameStatus: json["name_status"],
        colorStatus: json["color_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "name_request": nameRequest,
        "code": code,
        "name_status": nameStatus,
        "color_status": colorStatus,
    };
}
