import 'package:moociiap/Model/addBlogModels.dart';
import 'package:json_annotation/json_annotation.dart';

part 'videoModel.g.dart';

@JsonSerializable()
class VideoModel {
  String name;
  String username;
  String profession;
  String DOB;
  String titleline;
  String about;
  VideoModel(
      {this.DOB,
        this.about,
        this.name,
        this.profession,
        this.titleline,
        this.username});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
