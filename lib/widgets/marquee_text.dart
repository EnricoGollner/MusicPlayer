import 'package:flutter/cupertino.dart';

///Widget que cria um MarqueeText (Utilizado no nome da música)
class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double scrollSpeed;

  const MarqueeText({
    super.key, 
    required this.text,
    required this.style,
    this.scrollSpeed = 40.0,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late double _screenWidth;
  bool scrollOnce = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _startScrolling());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _startScrolling() async {
    while (true) {
      _scrollController.jumpTo(0);

      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(
          milliseconds: (_scrollController.position.maxScrollExtent / widget.scrollSpeed * 1000).toInt(),
        ),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: _screenWidth - 100,
      height: widget.style.fontSize! * 1.5,
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: [
          Row(
            children: [
              Text(widget.text, style: widget.style),
              SizedBox(width: _screenWidth),
            ],
          ),
        ],
      ),
    );
  }
}