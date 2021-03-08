import 'package:json_annotation/json_annotation.dart';

part 'pose.g.dart';

@JsonSerializable()
class Pose {
  String title;
  String sub;
  String benefits;

  Pose({
    this.title,
    this.sub,
    this.benefits,
  });

  factory Pose.fromJson(Map<String, dynamic> json) => _$PoseFromJson(json);

  Map<String, dynamic> toJson() => _$PoseToJson(this);
}
