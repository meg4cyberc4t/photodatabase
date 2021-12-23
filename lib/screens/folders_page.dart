import 'package:flutter/material.dart';

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
    return const Scaffold(
      key: PageStorageKey("folders"),
      body: Center(
        child: Text("Folders"),
      ),
    );
  }
}
