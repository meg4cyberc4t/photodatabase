import 'package:flutter/material.dart';
import 'package:photodatabase/api/longpolling.dart';

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
              return Text(snapshot.data.toString());
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
