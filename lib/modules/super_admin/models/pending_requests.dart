import 'dart:convert';

PendingRequests pendingRequestsFromJson(String str) => PendingRequests.fromJson(json.decode(str));

String pendingRequestsToJson(PendingRequests data) => json.encode(data.toJson());

class PendingRequests {
    List<Request> requests;

    PendingRequests({
        required this.requests,
    });

    factory PendingRequests.fromJson(Map<String, dynamic> json) => PendingRequests(
        requests: List<Request>.from(json["requests"].map((x) => Request.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
    };
}

class Request {
    int id;
    String fullName;
    String nameRequest;
    String code;
    String nameStatus;
    String colorStatus;

    Request({
        required this.id,
        required this.fullName,
        required this.nameRequest,
        required this.code,
        required this.nameStatus,
        required this.colorStatus,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
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
