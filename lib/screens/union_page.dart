import 'package:flutter/material.dart';

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
    return const Scaffold(
      key: PageStorageKey("union"),
      body: Center(
        child: Text("Union"),
      ),
    );
  }
}
