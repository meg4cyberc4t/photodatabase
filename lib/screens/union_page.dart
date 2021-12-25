import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';
import 'package:photodatabase/methods/custom_route.dart';
import 'package:photodatabase/screens/folder_page.dart';
import 'package:photodatabase/screens/image_page.dart';

class UnionPage extends StatefulWidget {
  const UnionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: const PageStorageKey("union"),
      body: StreamBuilder(
        stream: PhotoDatabaseLongPoolingApi.getUnion(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ConnectionState.done:
              return Center(
                  child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
            case ConnectionState.active:
              List data = snapshot.data as List;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(
                        MediaQuery.of(context).size.width * 0.15),
                    1: const FlexColumnWidth(),
                    2: const FlexColumnWidth(),
                  },
                  border: TableBorder.all(
                    color: Theme.of(context).backgroundColor,
                    width: 2,
                  ),
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "#",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Image",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color),
                          textAlign: TextAlign.start,
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Folder",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .color),
                          textAlign: TextAlign.start,
                        ),
                      )),
                    ]),
                    ...data.map((row) => TableRow(children: [
                          _TableItemButton(
                            title: row['photo_id'].toString(),
                            onPressed: null,
                          ),
                          _TableItemButton(
                            title: row['photo_title'],
                            onPressed: () => Navigator.push(
                              context,
                              customRoute(ImagePage(id: row['photo_id'])),
                            ),
                          ),
                          _TableItemButton(
                            title: row['folder_title'],
                            onPressed: () => Navigator.push(
                              context,
                              customRoute(FolderPage(id: row['folder_id'])),
                            ),
                          ),
                        ])),
                  ],
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

class _TableItemButton extends StatelessWidget {
  const _TableItemButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: InkWell(
      onTap: onPressed,
      focusColor: Theme.of(context).focusColor,
      hoverColor: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ));
  }
}
