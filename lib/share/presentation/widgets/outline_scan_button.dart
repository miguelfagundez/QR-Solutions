import 'package:flutter/material.dart';

class OutlineScanButton extends StatelessWidget {
  final Function() onTap;
  final Widget widget;

  const OutlineScanButton({
    super.key,
    required this.onTap,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 10.0,
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        onPressed: onTap,
        child: widget,
      ),
    );
  }
}
