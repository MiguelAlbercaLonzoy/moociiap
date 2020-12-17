// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    DOB: json['DOB'] as String,
    about: json['about'] as String,
    name: json['name'] as String,
    profession: json['docente'] as String,
    titleline: json['url'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'profession': instance.profession,
      'DOB': instance.DOB,
      'titleline': instance.titleline,
      'about': instance.about,
    };
