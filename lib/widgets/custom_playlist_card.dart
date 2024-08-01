import 'package:flutter/material.dart';

class CustomPlaylistCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget cover;
  final String title;

  const CustomPlaylistCard({super.key, required this.onTap, required this.cover, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: cover,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(title)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}