import 'package:json_annotation/json_annotation.dart';

part 'pose.g.dart';

@JsonSerializable()
class Pose {
  String title;
  String sub;

  Pose({
    this.title,
    this.sub,
  });

  factory Pose.fromJson(Map<String, dynamic> json) => _$PoseFromJson(json);

  Map<String, dynamic> toJson() => _$PoseToJson(this);
}
