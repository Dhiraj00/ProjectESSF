// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';


Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
    Place({
        this.htmlAttributions,
        this.nextPageToken,
        this.results,
        this.status,
    });

    List<dynamic> htmlAttributions;
    String nextPageToken;
    List<Result> results;
    String status;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: json["next_page_token"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
    };
}

class Result {
    Result({
        this.businessStatus,
        this.geometry,
        this.icon,
        this.name,
        this.placeId,
        this.reference,
        this.scope,
        this.types,
        this.vicinity,
        this.plusCode,
        this.rating,
        this.userRatingsTotal,
        this.openingHours,
        this.photos,
        this.priceLevel,
    });

    BusinessStatus businessStatus;
    Geometry geometry;
    String icon;
    String name;
    String placeId;
    String reference;
    Scope scope;
    List<String> types;
    String vicinity;
    PlusCode plusCode;
    double rating;
    int userRatingsTotal;
    OpeningHours openingHours;
    List<Photo> photos;
    int priceLevel;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus: json["business_status"] == null ? null : businessStatusValues.map[json["business_status"]],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        name: json["name"],
        placeId: json["place_id"],
        reference: json["reference"],
        scope: scopeValues.map[json["scope"]],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        userRatingsTotal: json["user_ratings_total"] == null ? null : json["user_ratings_total"],
        openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        priceLevel: json["price_level"] == null ? null : json["price_level"],
    );

    Map<String, dynamic> toJson() => {
        "business_status": businessStatus == null ? null : businessStatusValues.reverse[businessStatus],
        "geometry": geometry.toJson(),
        "icon": icon,
        "name": name,
        "place_id": placeId,
        "reference": reference,
        "scope": scopeValues.reverse[scope],
        "types": List<dynamic>.from(types.map((x) => x)),
        "vicinity": vicinity,
        "plus_code": plusCode == null ? null : plusCode.toJson(),
        "rating": rating == null ? null : rating,
        "user_ratings_total": userRatingsTotal == null ? null : userRatingsTotal,
        "opening_hours": openingHours == null ? null : openingHours.toJson(),
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "price_level": priceLevel == null ? null : priceLevel,
    };
}

enum BusinessStatus { OPERATIONAL }

final businessStatusValues = EnumValues({
    "OPERATIONAL": BusinessStatus.OPERATIONAL
});

class Geometry {
    Geometry({
        this.location,
        this.viewport,
    });

    Location location;
    Viewport viewport;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
    };
}

class Location {
    Location({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class Viewport {
    Viewport({
        this.northeast,
        this.southwest,
    });

    Location northeast;
    Location southwest;

    factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
    };
}

class OpeningHours {
    OpeningHours({
        this.openNow,
    });

    bool openNow;

    factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
    );

    Map<String, dynamic> toJson() => {
        "open_now": openNow,
    };
}

class Photo {
    Photo({
        this.height,
        this.htmlAttributions,
        this.photoReference,
        this.width,
    });

    int height;
    List<String> htmlAttributions;
    String photoReference;
    int width;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
    };
}

class PlusCode {
    PlusCode({
        this.compoundCode,
        this.globalCode,
    });

    String compoundCode;
    String globalCode;

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}

enum Scope { GOOGLE }

final scopeValues = EnumValues({
    "GOOGLE": Scope.GOOGLE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
