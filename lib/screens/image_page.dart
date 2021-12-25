import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PhotoDatabaseLongPoolingApi.getImage(id),
      builder: (context, snapshot) {
        String title = "Loading";
        Widget body = const Center(child: CircularProgressIndicator.adaptive());
        if (snapshot.connectionState == ConnectionState.done) {
          body = Center(
              child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
        } else if (snapshot.connectionState == ConnectionState.active) {
          var data = snapshot.data as Map;
          title = data['title'];
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ID: ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    data['id'].toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              if (data['description'].isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Description: ",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      data['description'],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create: ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    data['create_datatime'],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Last edit: ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    data['last_edit_datatime'],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          );
        }
        return Scaffold(
          key: PageStorageKey("image-$id"),
          appBar: AppBar(title: Text(title)),
          body: body,
        );
      },
    );
  }
}
