import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/models/playlist.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  Playlist? _selectedPlaylist;
  Playlist? get selectedPlaylist => _selectedPlaylist;

  void selectPlaylist(Playlist playlist) => _selectedPlaylist = playlist;

  final List<Playlist> _playlists = [
    Playlist(
      id: 1,
      title: 'Artlist.io musics',
      songs: [
        Song(
          id: 1,
          title: 'Fragility',
          artist: 'Romeo',
          albumCoverImagePath: 'assets/images/album_cover.jpg',
          audioPath: 'audio/fragility.mp3',
          fromAppAssets: true,
        ),
        Song(
          id: 2,
          title: 'Wild Peaks',
          artist: 'Tiko Tiko',
          albumCoverImagePath: 'assets/images/album_cover_2.jpg',
          audioPath: 'audio/wild_peaks.mp3',
          fromAppAssets: true,
        ),
        Song(
          id: 3,
          title: 'Game Over',
          artist: '2050',
          albumCoverImagePath: 'assets/images/album_cover_3.jpg',
          audioPath: 'audio/game_over.mp3',
          fromAppAssets: true,
        ),
        Song(
          id: 4,
          title: 'Wild Peaks',
          artist: 'Tiko Tiko',
          albumCoverImagePath: 'assets/images/album_cover_2.jpg',
          audioPath: 'audio/wild_peaks.mp3',
          fromAppAssets: true,
        ),
      ],
    ),
  ];

  List<Playlist> get playlists => _playlists;

  void removeSongFromPlaylist(int id) {
    _selectedPlaylist!.songs.removeWhere((song) => song.id == id);
    notifyListeners();
  }

  void createPlaylist(String title) {
    final Playlist newPlaylist = Playlist(
      id: playlists.length,
      title: title,
      songs: [],
    );
    playlists.add(newPlaylist);
    notifyListeners();
  }

  void addSongsToPlaylist(int playlistId, List<Song> newSongs) {
    for (Playlist playlist in _playlists) {
      if (playlist.id == playlistId) {
        playlist.songs.addAll(newSongs);
      }
    }
    notifyListeners();
  }

  /*  SONGS  */
  int? _currentSongIndex;
  int? get currentSongIndex => _currentSongIndex;
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) play(); //Play the song at the new index

    notifyListeners();
  }

  /* AUDIO PLAYER */
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> play() async {
    final Song song = _selectedPlaylist!.songs[_currentSongIndex!];

    await _audioPlayer.stop(); // Stop current song
    await _audioPlayer.play(song.fromAppAssets ? AssetSource(song.audioPath) : DeviceFileSource(song.audioPath));
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }
  
  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pauseOrResume() async {
    _isPlaying ? pause() : resume();
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _selectedPlaylist!.songs.length-1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;  // Loop back to the first song
      }
    }
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) { //If more than 2 seconds have passed, restart the current song
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1; //
      } else {
        currentSongIndex = _selectedPlaylist!.songs.length - 1; //If it's the first, play the last song
      }
    }
  }

  PlaylistProvider() {
    listenToDuration();
  }
  
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //Current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // Listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {

    });
  }
}