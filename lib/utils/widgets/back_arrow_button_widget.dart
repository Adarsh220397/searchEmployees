import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackArrowButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }
}
