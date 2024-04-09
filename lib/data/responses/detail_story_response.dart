import 'dart:convert';

DetailResponse detailStoryFromJson(String str) =>
    DetailResponse.fromJson(json.decode(str));

String detailStoryToJson(DetailResponse data) => json.encode(data.toJson());

class DetailResponse {
  bool error;
  String message;
  Story story;

  DetailResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailResponse.fromJson(Map<String, dynamic> json) => DetailResponse(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };
}

class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double lat;
  double lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"] != null ? json["lat"].toDouble() : 0.0,
        lon: json["lon"] != null ? json["lon"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
