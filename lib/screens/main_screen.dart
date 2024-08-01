import 'package:flutter/material.dart';
import 'package:music_player/models/playlist.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/widgets/custom_drawer.dart';
import 'package:music_player/widgets/custom_playlist_card.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    playlistProvider = Provider.of(context, listen: false);
    super.initState();
  }

  void _goToPlaylist(Playlist playlist) {
    playlistProvider.selectPlaylist(playlist);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaylistScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('P L A Y L I S T S'),
        actions: [
            IconButton(
              tooltip: 'Criar Playlist',
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  context: context, builder: (context) {
                  return Container(
                    color: Colors.white,
                    child: const Text('Criar Playlist'),
                  );
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
      ),
      drawer: const CustomDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          final List<Playlist> playlists = playlistProvider.playlists;

          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
                final Playlist playlist = playlists[index];
                return CustomPlaylistCard(
                  onTap: () => _goToPlaylist(playlist),
                  cover: playlist.cover!,
                  title: playlist.title,
                );
              },
            );
        },
      )
    );
  }
}