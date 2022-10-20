import 'dart:convert';

JwPlayerConfiguration jwPlayerConfigurationFromJson(String str) =>
    JwPlayerConfiguration.fromJson(json.decode(str));

String jwPlayerConfigurationToJson(JwPlayerConfiguration data) =>
    json.encode(data.toJson());

class JwPlayerConfiguration {
  JwPlayerConfiguration({
    this.file,
    this.image,
    this.width,
    this.height,
    this.title,
    this.description,
  });

  String? file;
  String? image;
  String? width;
  String? height;
  String? title;
  String? description;

  factory JwPlayerConfiguration.fromJson(Map<String, dynamic> json) =>
      JwPlayerConfiguration(
        file: json["file"],
        image: json["image"],
        width: json["width"],
        height: json["height"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "image": image,
        "width": width,
        "height": height,
        "title": title,
        "description": description,
      };
}
