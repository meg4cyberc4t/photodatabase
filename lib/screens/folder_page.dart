import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PhotoDatabaseLongPoolingApi.getFolder(id),
      builder: (context, snapshot) {
        String title = "Loading";
        Widget body = const Center(child: CircularProgressIndicator.adaptive());
        if (snapshot.connectionState == ConnectionState.done) {
          body = Center(
              child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          var data = snapshot.data as Map;
          title = data['title'];
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ID: ${data['id']}",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              if (data['description'].isNotEmpty)
                Text(
                  "Description: ${data['description']}",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              Text(
                "Create: ${data['create_datatime']}",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                "Last edit:: ${data['last_edit_datatime']}",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
        return Scaffold(
          key: PageStorageKey("folder-$id"),
          appBar: AppBar(title: Text(title)),
          body: body,
        );
      },
    );
  }
}
