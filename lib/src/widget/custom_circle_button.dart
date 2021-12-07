import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomCircleButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const SizedBox(height: 50, child: Icon(Icons.add, size: 30)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade800),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
      ),
    );
  }
}
