import 'package:flutter/material.dart';
import 'package:photodatabase/configs/colors.dart';

class FolderItem extends StatelessWidget {
  const FolderItem({
    required this.id,
    required this.title,
    required this.description,
    required this.createDatetime,
    required this.lastEditDatetime,
    Key? key,
  }) : super(key: key);
  final int id;
  final String title;
  final String description;
  final String createDatetime;
  final String lastEditDatetime;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        focusColor: PhotoDatabaseColors.primaryBackground.withOpacity(0.5),
        hoverColor: PhotoDatabaseColors.primaryBackground.withOpacity(0.5),
        color: Colors.primaries[id % 10],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              if (description.isNotEmpty)
                Text(
                  description,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).textTheme.headline4!.color),
                ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
