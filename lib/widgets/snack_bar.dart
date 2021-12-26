import 'package:flutter/material.dart';

class PhotodatabaseSnackBar extends StatelessWidget {
  const PhotodatabaseSnackBar({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
