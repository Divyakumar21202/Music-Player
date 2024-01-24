// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SongModel {
  final String title;
  final String description;
  final String songUrl;
  final String coverUrl;
  final String uploadedby;


  SongModel(
      {required this.title,
      required this.description,
      required this.songUrl,
      required this.coverUrl,
      required this.uploadedby,
      });
 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'songUrl': songUrl,
      'coverUrl': coverUrl,
      'uploadedby': uploadedby,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
    title:   map['title'] as String,
     description:  map['description'] as String,
    songUrl:   map['songUrl'] as String,
     coverUrl:  map['coverUrl'] as String,
    uploadedby:  map['uploadedby'] as String,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) => SongModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
