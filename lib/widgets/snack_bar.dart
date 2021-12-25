import 'package:flutter/material.dart';
import 'package:photodatabase/api/error.dart';

class PhotodatabaseSnackBar extends StatelessWidget {
  const PhotodatabaseSnackBar({
    Key? key,
    required this.err,
  }) : super(key: key);

  final PhotoDatabaseApiError err;

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        err.message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
