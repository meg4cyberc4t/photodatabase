import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';
import 'package:photodatabase/methods/custom_route.dart';
import 'package:photodatabase/screens/image_page.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: const PageStorageKey("images"),
      floatingActionButton: CupertinoButton(
        child: const Icon(Icons.file_upload_outlined),
        color: Theme.of(context).primaryColor,
        onPressed: () {},
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
                  onTap: () => Navigator.push(
                      context, customRoute(ImagePage(id: list[index]['id']))),
                  child: CachedNetworkImage(
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
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 300 ? 3 : 2,
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
