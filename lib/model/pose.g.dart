// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pose _$PoseFromJson(Map<String, dynamic> json) {
  return Pose(
    title: json['title'] as String,
    sub: json['sub'] as String,
    benefits: json['benefits'] as String,
  );
}

Map<String, dynamic> _$PoseToJson(Pose instance) => <String, dynamic>{
      'title': instance.title,
      'sub': instance.sub,
      'benefits': instance.benefits,
    };
