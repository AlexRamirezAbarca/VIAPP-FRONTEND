
import 'dart:convert';

RequestResponse requestResponseFromJson(String str) => RequestResponse.fromJson(json.decode(str));

String requestResponseToJson(RequestResponse data) => json.encode(data.toJson());

class RequestResponse {
    List<Request> requests;

    RequestResponse({
        required this.requests,
    });

    factory RequestResponse.fromJson(Map<String, dynamic> json) => RequestResponse(
        requests: List<Request>.from(json["requests"].map((x) => Request.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
    };
}

class Request {
    int id;
    String nameRequest;
    String requestCode;
    String descriptionRequest;
    int statusRequest;

    Request({
        required this.id,
        required this.nameRequest,
        required this.requestCode,
        required this.descriptionRequest,
        required this.statusRequest,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        nameRequest: json["name_request"],
        requestCode: json["request_code"],
        descriptionRequest: json["description_request"],
        statusRequest: json["status_request"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_request": nameRequest,
        "request_code": requestCode,
        "description_request": descriptionRequest,
        "status_request": statusRequest,
    };

   
}
