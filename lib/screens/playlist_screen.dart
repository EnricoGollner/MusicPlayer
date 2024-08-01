import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
            itemCount: playlist.songs.length + 1,
            itemBuilder: (context, index) {
              if (index == playlist.songs.length) {
                return ListTile(
                  onTap: () async => await _addNewSong(playlist),
                  leading: const Icon(Icons.add),
                  title: const Text('Adiconar nova música'),
                );
              }
          
              final Song song = playlist.songs[index];
                return Dismissible(
                  key: ValueKey(song.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Remover Música'),
                          content: const Text('Você tem certeza que deseja remover esta música da Playlist?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                'Remover',
                                style: TextStyle( color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (_) => playlistProvider.removeSongFromPlaylist(song.id),
                  background: ColoredBox(
                    color: Theme.of(context).colorScheme.error,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(song.albumCoverImagePath),
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                    onTap: () => _goToSong(index),
                    trailing: const Icon(Icons.play_arrow),
                  ),
                );
              },
            );
        },
      )
    );
  }

  Future<void> _addNewSong(Playlist playlist) async {
    FilePickerResult? songsFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
      allowMultiple: true,
    );

    if (songsFiles != null) {
      final List<Song> songs = songsFiles.paths.map((path) => File(path!)).toList().map((songFile) {
        final Song newSong = Song(
          id: playlist.songs.length,
          title: songFile.path.split('/').last,
          artist: 'Artista Desconhecido',
          albumCoverImagePath: 'assets/images/song_cover.png',
          audioPath: songFile.path,
        );
        return newSong;
      }).toList();

      playlistProvider.addSongsToPlaylist(playlist.id, songs);
    }
  }
}