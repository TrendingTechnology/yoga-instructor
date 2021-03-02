// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    poses: (json['poses'] as List)
        ?.map(
            (e) => e == null ? null : Pose.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    name: json['name'] as String,
    desc: json['desc'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'poses': instance.poses,
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'count': instance.count,
    };
