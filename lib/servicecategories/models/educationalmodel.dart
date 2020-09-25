// To parse this JSON data, do
//
//     final educational = educationalFromJson(jsonString);

import 'dart:convert';

List<Educational> educationalFromJson(String str) => List<Educational>.from(json.decode(str).map((x) => Educational.fromJson(x)));

String educationalToJson(List<Educational> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Educational {
    Educational({
        this.name,
        this.phone,
        this.website,
    });

    String name;
    String phone;
    String website;

    factory Educational.fromJson(Map<String, dynamic> json) => Educational(
        name: json["name"],
        phone: json["phone"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "website": website,
    };
}
