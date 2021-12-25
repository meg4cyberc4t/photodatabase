import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
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
        } else if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          var data = snapshot.data as Map;
          title = data['title'];
          body = Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ID: " + data['id'].toString(),
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (data['description'].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Description: " + data['description'],
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Loaded: " + data['load_datatime'],
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Last edit: " + data['last_edit_datatime'],
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: PhotoDatabaseApi.images.getShowLink(id),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator.adaptive(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
