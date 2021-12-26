import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
import 'package:photodatabase/components/error_widget.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PhotoDatabaseApi.images.getById(id),
      builder: (context, snapshot) {
        String title = "Loading";
        Widget body = const Center(child: CircularProgressIndicator.adaptive());
        if (snapshot.hasError) {
          body = Center(
              child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          var data = snapshot.data as Map;
          title = data['title'];
          body = CachedNetworkImage(
            cacheKey: id.toString(),
            imageUrl: PhotoDatabaseApi.images.getShowLink(id),
            fit: BoxFit.contain,
            width: double.infinity,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator.adaptive(
                    value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(
              Icons.warning_amber_rounded,
              color: Colors.yellow,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: body,
        );
      },
    );
  }
}
