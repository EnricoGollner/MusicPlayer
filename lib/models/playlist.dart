import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class Playlist {
  final int id;
  Widget? cover;
  final String title;
  final List<Song> songs;

  Playlist({required this.id, this.cover, required this.title, required this.songs}) {
    cover = songs.length >= 4
    ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 4,
            itemBuilder: (context, index) => Image.asset(
              songs[index].albumArtImagePath,
              fit: BoxFit.contain,
            ),
    ) : Image.asset(songs.first.albumArtImagePath, fit: BoxFit.contain);
  }
}