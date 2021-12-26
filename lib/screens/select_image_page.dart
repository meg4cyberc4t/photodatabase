import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class SelectImagePage extends StatefulWidget {
  const SelectImagePage({Key? key}) : super(key: key);

  @override
  State<SelectImagePage> createState() => _SelectImagePageState();
}

class _SelectImagePageState extends State<SelectImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const PageStorageKey("images"),
      floatingActionButton: CupertinoButton(
        child: const Icon(Icons.file_upload_outlined),
        color: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).pushNamed('/LoadImagePage'),
      ),
      body: StreamBuilder(
        stream: PhotoDatabaseLongPoolingApi.getImages(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ConnectionState.done:
              return Center(
                  child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
            case ConnectionState.active:
              var list = snapshot.data as List;
              return WaterfallFlow.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).pop(list[index]['id']),
                  child: CachedNetworkImage(
                    width: 300,
                    fit: BoxFit.fitWidth,
                    cacheKey: list[index]['id'].toString(),
                    imageUrl:
                        PhotoDatabaseApi.images.getShowLink(list[index]['id']),
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
                itemCount: list.length,
                padding: const EdgeInsets.all(10.0),
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 300,
                ),
              );
            case ConnectionState.none:
              return const Center(child: Text('None'));
          }
        },
      ),
    );
  }
}
