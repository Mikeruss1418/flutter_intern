import 'package:movie_app/domain/entities/video_entity.dart';

class VideoResultModel {
  int? id;
  List<VideoModel>? videos;

  VideoResultModel({this.id, this.videos});

  VideoResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      videos = <VideoModel>[];
      json['results'].forEach((v) {
        videos!.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (videos != null) {
      data['results'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoModel extends VideoEntity {
  final String? iso6391;
  final String? iso31661;
  final String name; //title
  final String key; //key
  final String? site;
  final int? size;
  final String type;
  final bool? official;
  final String? publishedAt;
  final String? id;

  VideoModel(
      {this.iso6391,
      this.iso31661,
      required this.name,
      required this.key,
      this.site,
      this.size,
      required this.type,
      this.official,
      this.publishedAt,
      this.id})
      : super(name, type, key);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
    iso6391 :json['iso_639_1'],
    iso31661 : json['iso_3166_1'],
    name : json['name'],
    key :json['key'],
    site: json['site'],
    size: json['size'],
    type : json['type'],
    official : json['official'],
    publishedAt : json['published_at'],
    id :json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['key'] = key;
    data['site'] = site;
    data['size'] = size;
    data['type'] = type;
    data['official'] = official;
    data['published_at'] = publishedAt;
    data['id'] = id;
    return data;
  }
}
