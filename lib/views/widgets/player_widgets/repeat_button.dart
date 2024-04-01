import 'package:flutter/material.dart';

class RepeatButton extends StatefulWidget {
  const RepeatButton({super.key, required this.isRepeatOn, required this.onChange});
  final bool isRepeatOn;
  final Function(bool newValue) onChange;

  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {
  bool isRepeatOn = false;

  @override
  void initState() {
    isRepeatOn = widget.isRepeatOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isRepeatOn = !isRepeatOn;
        widget.onChange(isRepeatOn);
        setState(() {});
      },
      icon: Icon(isRepeatOn ? Icons.repeat_one_on_rounded : Icons.repeat_rounded, size: 24),
    );
  }
}
