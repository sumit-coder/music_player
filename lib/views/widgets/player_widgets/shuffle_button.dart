import 'package:flutter/material.dart';

class ShuffleButton extends StatefulWidget {
  const ShuffleButton({super.key, required this.isShuffleOn, required this.onChange});
  final bool isShuffleOn;
  final Function(bool newValue) onChange;

  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton> {
  bool isShuffleOn = false;

  @override
  void initState() {
    isShuffleOn = widget.isShuffleOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isShuffleOn = !isShuffleOn;
        widget.onChange(isShuffleOn);
        setState(() {});
      },
      icon: Icon(isShuffleOn ? Icons.shuffle_on_rounded : Icons.shuffle_rounded, size: 24),
    );
  }
}
