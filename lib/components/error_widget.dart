import 'package:flutter/material.dart';

class PhotoDatabaseErrorWidget extends StatelessWidget {
  const PhotoDatabaseErrorWidget(this.errorTitle, [Key? key]) : super(key: key);
  final String errorTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.yellow,
          size: 40,
        ),
        Text(errorTitle.toString()),
      ],
    );
  }
}
