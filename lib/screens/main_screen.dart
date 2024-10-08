import 'package:flutter/material.dart';
import 'package:music_player/models/playlist.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/widgets/custom_drawer.dart';
import 'package:music_player/widgets/custom_playlist_card.dart';
import 'package:music_player/widgets/custom_text_field.dart';
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
              onPressed: _showDialogCreatePlaylist,
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
                  cover: _buildPlaylistCover(playlist.songs),
                  title: playlist.title,
                );
              },
            );
          },
      )
    );
  }
  
  void _showDialogCreatePlaylist() {
    final TextEditingController ctrlTitle = TextEditingController();

    void createPlaylist() {
      playlistProvider.createPlaylist(ctrlTitle.text);
      ctrlTitle.clear();
      Navigator.pop(context);
    }

    showGeneralDialog(
      context: context,
      barrierLabel: 'Barrier',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Criar Playlist',
                              style: TextStyle(fontSize: 19),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: ctrlTitle,
                          isAutoFocus: true,
                          textCapitalization: TextCapitalization.words,
                          label: 'Título:', 
                          hintText: 'Informe o título da playlist',
                          onFieldSubmitted: (_) => createPlaylist(),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          onPressed: createPlaylist,
                          child: Text(
                            'CRIAR',
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylistCover(List<Song> songs) {
    if (songs.isEmpty) return Image.asset('assets/images/song_cover.png', fit: BoxFit.contain);

    return songs.length >= 4
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 4,
          itemBuilder: (context, index) => Image.asset(
            songs[index].albumCoverImagePath,
            fit: BoxFit.contain,
          ),
        )
      : Image.asset(songs.first.albumCoverImagePath, fit: BoxFit.contain);
  }
}