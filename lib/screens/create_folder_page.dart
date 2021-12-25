import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodatabase/api/api.dart';
import 'package:photodatabase/api/error.dart';
import 'package:photodatabase/widgets/snack_bar.dart';

class CreateFolderPage extends StatefulWidget {
  const CreateFolderPage({Key? key}) : super(key: key);

  @override
  State<CreateFolderPage> createState() => _CreateFolderPageState();
}

class _CreateFolderPageState extends State<CreateFolderPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
                  child: const Text('Create'),
                  onPressed: () async {
                    try {
                      await PhotoDatabaseApi.folders.create(
                          _titleController.text, _descriptionController.text);
                      Navigator.of(context).pop();
                    } on PhotoDatabaseApiError catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          PhotodatabaseSnackBar(err: err).build(context));
                    }
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
