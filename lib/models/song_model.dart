class Song {
  final String title;
  final String description;
  final String Url;
  final String coverUrl;

  Song(
      {required this.title,
      required this.description,
      required this.Url,
      required this.coverUrl});
  static List<Song> song = [
    Song(title: 'Chaleya', description: 'description', Url: 'Url', coverUrl: 'coverUrl')
  ];
}
