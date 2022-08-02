// To parse this JSON data, do
//
//     final giphyModel = giphyModelFromJson(jsonString);

import 'dart:convert';

GiphyModel giphyModelFromJson(String str) =>
    GiphyModel.fromJson(json.decode(str));

class GiphyModel {
  GiphyModel({
    required this.data,
  });

  List<Datum> data;

  factory GiphyModel.fromJson(Map<String, dynamic> json) => GiphyModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.username,
    required this.title,
    required this.images,
  });

  String username;
  String title;
  Images images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        username: json["username"],
        title: json["title"],
        images: Images.fromJson(json["images"]),
      );
}

class Images {
  Images({
    required this.original,
  });

  Original original;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: Original.fromJson(json["original"]),
      );
}

class Original {
  Original({
    required this.url,
  });

  String url;

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        url: json["url"],
      );
}
