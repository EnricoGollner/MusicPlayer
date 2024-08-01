import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/widgets/custom_box.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  String _formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, playlistProvider, child) {
        final Song currentSong = playlistProvider.selectedPlaylist!.songs[playlistProvider.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'S O N G',
              style: TextStyle(fontSize: 19),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ListTile(
                      leading: Image.asset(currentSong.albumArtImagePath),
                      title: Text(currentSong.songName),
                      subtitle: Text(currentSong.artistName),
                    ),
                  );
                },
                icon: const Icon(Icons.menu),
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _buildHeader(context),
                  // const SizedBox(height: 25),
                  CustomBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artistName),
                                ],
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatTime(playlistProvider.currentDuration)),
                        const Icon(Icons.shuffle),
                        const Icon(Icons.repeat),
                        Text(_formatTime(playlistProvider.totalDuration)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                    ),
                    child: Slider(
                      min: 0,
                      max: playlistProvider.totalDuration.inSeconds.toDouble(),
                      value: playlistProvider.currentDuration.inSeconds.toDouble(),
                      inactiveColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      activeColor: Colors.green,
                      onChanged: (position) {
                        //During when the user is sliding arround
                      },
                      onChangeEnd: (position) {
                        //Sliding has finished
                        playlistProvider.seek(Duration(seconds: position.toInt()));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: playlistProvider.playPreviousSong,
                          child: const CustomBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: playlistProvider.pauseOrResume,
                          child:  CustomBox(
                            child: Icon(playlistProvider.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: playlistProvider.playNextSong,
                          child: const CustomBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Row _buildHeader(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       IconButton(
  //         onPressed: () => Navigator.pop(context),
  //         icon: const Icon(Icons.arrow_back),
  //       ),
  //       const Text('S O N G'),
  //       IconButton(
  //         onPressed: () {},
  //         icon: const Icon(Icons.menu),
  //       )
  //     ],
  //   );
  // }
}
