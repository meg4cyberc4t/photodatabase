import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
import 'package:photodatabase/components/error_widget.dart';
import 'package:photodatabase/methods/custom_route.dart';
import 'package:photodatabase/screens/edit_folder_page.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  AppinioSwiperController controller = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PhotoDatabaseApi.folders.getById(widget.id),
      builder: (context, snapshot) {
        String title = "Loading";
        String description = "";

        Widget body = const Center(child: CircularProgressIndicator.adaptive());
        if (snapshot.hasError) {
          body = Center(
              child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          var data = snapshot.data as Map;
          List<Widget> cards = [];
          for (var photo in data['photos']) {
            cards.add(CachedNetworkImage(
              cacheKey: photo['id'].toString(),
              imageUrl: PhotoDatabaseApi.images.getShowLink(photo['id']),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator.adaptive(
                      value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(
                Icons.warning_amber_rounded,
                color: Colors.yellow,
              ),
            ));
          }
          title = data['title'];
          description = data['description'];

          body = SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  if (cards.isNotEmpty)
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppinioSwiper(
                          cards: cards,
                          controller: controller,
                          allowUnswipe: true,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 10),
                  if (cards.isNotEmpty)
                    CupertinoButton(
                      child: const Text("Unswipe"),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => controller.unswipe(),
                    ),
                ],
              ),
            ),
          );
        } else {
          title = "Loading";
          description = "";
          body = const Center(child: CircularProgressIndicator.adaptive());
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                icon: const Icon(Icons.link_outlined),
                onPressed: () async {
                  final int? id = await Navigator.of(context)
                      .pushNamed('/SelectImagePage') as int?;
                  if (id != null) {
                    PhotoDatabaseApi.folders.addImage(widget.id, id);
                    Navigator.of(context).pop();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  var check = await Navigator.of(context)
                      .push(customRoute(EditFolderPage(
                    title: title,
                    description: description,
                  )));
                  PhotoDatabaseApi.folders.edit(widget.id, check[0], check[1]);
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await PhotoDatabaseApi.folders.delete(widget.id);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: body,
        );
      },
    );
  }
}
