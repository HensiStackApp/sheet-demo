// To parse this JSON data, do
//
//     final providerResponse = providerResponseFromJson(jsonString);

import 'dart:convert';

List<ProviderResponse> providerResponseFromJson(String str) =>
    List<ProviderResponse>.from(json.decode(str).map((x) => ProviderResponse.fromJson(x)));

String providerResponseToJson(List<ProviderResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderResponse {
  ProviderResponse({
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

  factory ProviderResponse.fromJson(Map<String, dynamic> json) => ProviderResponse(
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
