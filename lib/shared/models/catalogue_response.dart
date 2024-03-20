import 'dart:convert';

CatalogueResponse catalogueResponseFromJson(String str) => CatalogueResponse.fromJson(json.decode(str));

String catalogueResponseToJson(CatalogueResponse data) => json.encode(data.toJson());

class CatalogueResponse {
    List<Catalogue> charge;
    List<Catalogue> area;

    CatalogueResponse({
        required this.charge,
        required this.area,
    });

    factory CatalogueResponse.fromJson(Map<String, dynamic> json) => CatalogueResponse(
        charge: List<Catalogue>.from(json["charge"].map((x) => Catalogue.fromJson(x))),
        area: List<Catalogue>.from(json["area"].map((x) => Catalogue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "charge": List<dynamic>.from(charge.map((x) => x.toJson())),
        "area": List<dynamic>.from(area.map((x) => x.toJson())),
    };
}

class Catalogue {
    int id;
    String name;

    Catalogue({
        required this.id,
        required this.name,
    });

    factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
