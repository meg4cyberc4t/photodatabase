import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';
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
      body: Center(
        child: StreamBuilder(
          stream: PhotoDatabaseLongPoolingApi.getAllFolders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data as List;
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: [
                  ...list.map(
                    (e) => FolderItem(
                      id: e['id'],
                      title: e['title'],
                      description: e['description'],
                      createDatetime: e['create_datatime'],
                      lastEditDatetime: e['last_edit_datatime'],
                    ),
                  )
                ],
                scrollDirection: Axis.horizontal,
              );
              // return Text(snapshot.data.toString());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Text('loading');
          },
        ),
      ),
    );
  }
}
