import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  int? _currentSongIndex;

  final List<Song> _playlist = [
    Song(
      songName: 'Wild Peaks',
      artistName: 'Artist 1',
      albumArtImagePath: 'assets/images/album.jpg',
      audioPath: 'assets/audio/wild_peaks.mp3'
    ),
    Song(
      songName: 'Wild Peaks 2',
      artistName: 'Artist 2',
      albumArtImagePath: 'assets/images/album.jpg',
      audioPath: 'assets/audio/wild_peaks.mp3'
    ),
    Song(
      songName: 'Wild Peaks 3',
      artistName: 'Artist 3',
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

  /* AUDIO PLAYER */
  final AudioPlayer _audioPlayer = AudioPlayer();
}