import 'package:json_annotation/json_annotation.dart';

part 'pose.g.dart';

@JsonSerializable()
class Pose {
  String title;
  String sub;
  String benefits;
  @JsonKey(name: 'video_url')
  String videoUrl;
  @JsonKey(name: 'pause_points')
  List<int> pausePoints;

  Pose({
    this.title,
    this.sub,
    this.benefits,
    this.videoUrl,
    this.pausePoints,
  });

  factory Pose.fromJson(Map<String, dynamic> json) => _$PoseFromJson(json);

  Map<String, dynamic> toJson() => _$PoseToJson(this);
}
