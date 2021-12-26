import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';
import 'package:photodatabase/components/error_widget.dart';
import 'package:photodatabase/configs/colors.dart';
import 'package:photodatabase/widgets/folder_item.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: const PageStorageKey("folders"),
      body: StreamBuilder(
        stream: PhotoDatabaseLongPoolingApi.getAllFolders(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ConnectionState.done:
              return Center(
                  child: PhotoDatabaseErrorWidget(snapshot.error.toString()));
            case ConnectionState.active:
              var list = snapshot.data as List;
              return GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: [
                  ...list.map(
                    (e) => FolderItem(
                      id: e['id'],
                      title: e['title'],
                      description: e['description'],
                      
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      focusColor: PhotoDatabaseColors.primaryBackground
                          .withOpacity(0.5),
                      hoverColor: PhotoDatabaseColors.primaryBackground
                          .withOpacity(0.5),
                      color: Theme.of(context).primaryColor,
                      minWidth: 50,
                      height: 50,
                      child: const Center(
                        child: Icon(Icons.add),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/CreateFolderPage'),
                    ),
                  ),
                ],
                scrollDirection: Axis.vertical,
              );
            case ConnectionState.none:
              return const Center(child: Text('None'));
          }
        },
      ),
    );
  }
}
