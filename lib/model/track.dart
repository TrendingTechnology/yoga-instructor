import 'package:json_annotation/json_annotation.dart';
import 'package:sofia/model/pose.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  int id;
  String name;
  String desc;
  int count;

  Track({
    this.id,
    this.name,
    this.desc,
    this.count,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
