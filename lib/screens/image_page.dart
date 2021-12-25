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
          body = CachedNetworkImage(
            cacheKey: id.toString(),
            imageUrl: PhotoDatabaseApi.images.getShowLink(id),
            imageBuilder: (context, imageProvider) => Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: (data['description'].isEmpty)
                      ? const Spacer()
                      : Text(data['description']),
                ),
              ),
            ),
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
          key: PageStorageKey("image-$id"),
          appBar: AppBar(title: Text(title)),
          body: body,
        );
      },
    );
  }
}
