import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditFolderPage extends StatefulWidget {
  const EditFolderPage({Key? key, this.title = "", this.description = ""})
      : super(key: key);
  final String title;
  final String description;

  @override
  State<EditFolderPage> createState() => _EditFolderPageState();
}

class _EditFolderPageState extends State<EditFolderPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create folder"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width < 300
                ? MediaQuery.of(context).size.width
                : 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  maxLines: 1,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: 'Folder title',
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  controller: _titleController,
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 1,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: 'Folder description',
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.of(context).pop(
                        [_titleController.text, _descriptionController.text]);
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
