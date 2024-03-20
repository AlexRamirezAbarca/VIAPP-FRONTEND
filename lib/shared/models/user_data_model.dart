import 'dart:convert';

DataUserModel dataUserModelFromJson(String str) =>
    DataUserModel.fromJson(json.decode(str));

String dataUserModelToJson(DataUserModel data) => json.encode(data.toJson());

class DataUserModel {
  final String identificacion;
  final String clave;

  DataUserModel({
    required this.identificacion,
    required this.clave,
  });

  factory DataUserModel.fromJson(Map<String, dynamic> json) => DataUserModel(
        identificacion: json["identificacion"],
        clave: json["clave"],
      );

  Map<String, dynamic> toJson() => {
        "identificacion": identificacion,
        "clave": clave,
      };
}
