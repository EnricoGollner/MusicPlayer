import 'package:flutter/material.dart';

import 'package:music_player/models/song.dart';

class Playlist {
  final int id;
  Widget? cover;
  final String title;
  final List<Song> songs;

  Playlist({required this.id, this.cover, required this.title, required this.songs});
}
