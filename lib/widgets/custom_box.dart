import 'package:flutter/material.dart';
import 'package:music_player/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomBox extends StatelessWidget {
  final Widget? child;

  const CustomBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            blurRadius: 15,
            offset: const Offset(-4, -4),
          ),
        ]
      ),
      child: child,
    );
  }
}