// To parse this JSON data, do
//
//     final helpline = helplineFromJson(jsonString);

import 'dart:convert';

List<Helpline> helplineFromJson(String str) => List<Helpline>.from(json.decode(str).map((x) => Helpline.fromJson(x)));

String helplineToJson(List<Helpline> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Helpline {
    Helpline({
        this.name,
        this.phone,
    });

    String name;
    String phone;

    factory Helpline.fromJson(Map<String, dynamic> json) => Helpline(
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
    };
}
