
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
      child: Text(
        "$text*",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }
}
