import 'dart:convert';

List<DemoPageApiModel> demoPageApiModelFromJson(String str) =>
    List<DemoPageApiModel>.from(json.decode(str).map((x) => DemoPageApiModel.fromJson(x)));

String demoPageApiModelToJson(List<DemoPageApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DemoPageApiModel {
  DemoPageApiModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  factory DemoPageApiModel.fromJson(Map<String, dynamic> json) => DemoPageApiModel(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
