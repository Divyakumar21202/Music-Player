class SongModel {
  final String title;
  final String description;
  final String songUrl;
  final String coverUrl;

  SongModel(
      {required this.title,
      required this.description,
      required this.songUrl,
      required this.coverUrl});
  static List<SongModel> song = [
    SongModel(
        title: 'Chaleya',
        description: 'description',
        songUrl: 'Url',
        coverUrl: 'coverUrl')
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'songUrl': songUrl,
      'coverUrl': coverUrl,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      title: map['title'] as String,
      description: map['description'] as String,
      songUrl: map['songUrl'] as String,
      coverUrl: map['coverUrl'] as String,
    );
  }
}
