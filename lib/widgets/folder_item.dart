import 'package:flutter/material.dart';
import 'package:photodatabase/configs/colors.dart';
import 'package:photodatabase/methods/custom_route.dart';
import 'package:photodatabase/screens/folder_page.dart';

class FolderItem extends StatelessWidget {
  const FolderItem({
    required this.id,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);
  final int id;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        focusColor: PhotoDatabaseColors.primaryBackground.withOpacity(0.5),
        hoverColor: PhotoDatabaseColors.primaryBackground.withOpacity(0.5),
        color: Colors.primaries[id % 10],
        minWidth: 50,
        height: 50,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              if (description.isNotEmpty)
                Text(
                  description,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
        onPressed: () =>
            Navigator.push(context, customRoute(FolderPage(id: id))),
      ),
    );
  }
}
