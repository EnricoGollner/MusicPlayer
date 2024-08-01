import 'package:flutter/material.dart';
import 'package:music_player/models/playlist.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/screens/song_screen.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late final PlaylistProvider playlistProvider;
  late Playlist _selectedPlaylist;

  @override
  void initState() {
    playlistProvider = Provider.of(context, listen: false);
    _selectedPlaylist = playlistProvider.selectedPlaylist!;
    super.initState();
  }

  void _goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SongScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_selectedPlaylist.title),
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          final Playlist playlist = playlistProvider.selectedPlaylist!;

          return ListView.builder(
            itemCount: playlist.songs.length,
            itemBuilder: (context, index) {
                final Song song = playlist.songs[index];
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => _goToSong(index),
                );
              },
            );
        },
      )
    );
  }
}