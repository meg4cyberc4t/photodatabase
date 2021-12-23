import 'package:flutter/material.dart';

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
    return const Scaffold(
      key: PageStorageKey("images"),
      body: Center(
        child: Text("Images"),
      ),
    );
  }
}
