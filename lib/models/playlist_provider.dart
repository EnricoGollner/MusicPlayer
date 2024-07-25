import 'package:flutter/cupertino.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  int? _currentSongIndex;

  final List<Song> _playlist = [
    Song(
      songName: 'Wild Peaks',
      artistName: 'Artist here',
      albumArtImagePath: 'assets/images/album.jpg',
      audioPath: 'assets/audio/wild_peaks.mp3'
    ),
    Song(
      songName: 'Wild Peaks 3',
      artistName: 'Artist here 3',
      albumArtImagePath: 'assets/images/album.jpg',
      audioPath: 'assets/audio/wild_peaks.mp3'
    ),
    Song(
      songName: 'Wild Peaks 3',
      artistName: 'Artist here 3',
      albumArtImagePath: 'assets/images/album.jpg',
      audioPath: 'assets/audio/wild_peaks.mp3'
    ),
  ];

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}