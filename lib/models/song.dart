class Song {
  final int id;
  final String title;
  final String artist;
  final String albumCoverImagePath;
  final String audioPath;
  final bool fromAppAssets;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumCoverImagePath,
    required this.audioPath,
    this.fromAppAssets = false
  });
}