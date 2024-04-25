import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_story_response.freezed.dart';
part 'detail_story_response.g.dart';

@freezed
class DetailResponse with _$DetailResponse {
  const factory DetailResponse({
    required bool error,
    required String message,
    required Story story,
  }) = _DetailResponse;

  factory DetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailResponseFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
