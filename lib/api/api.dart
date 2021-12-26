import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:http_parser/http_parser.dart';

import 'package:photodatabase/api/error.dart';

class PhotoDatabaseApi {
  static const String server = "http://192.168.0.118:1116";
  // static const String server = "http://192.168.1.71:1116";
  // static const String server = "http://db-learning.ithub.ru:1116";
  static _Folders get folders => const _Folders(server);
  static _Images get images => const _Images(server);
}

__errorHandler(out) {
  if (out.containsKey('error')) {
    throw PhotoDatabaseApiError(out['error']);
  }
  return out;
}

class _Folders {
  const _Folders(this.server);
  final String server;

  Future<void> create(String title, String description) async {
    http.Response res =
        await http.post(Uri.parse(server + "/api/folder"), body: {
      "title": title,
      "description": description,
    });
    __errorHandler(jsonDecode(res.body));
  }

  dynamic getAll() async {
    http.Response res = await http.get(Uri.parse(server + "/api/folder"));
    return __errorHandler(jsonDecode(res.body));
  }
}

class _Images {
  const _Images(this.server);
  final String server;
  String getShowLink(id) {
    return server + "/api/image/$id/show";
  }

  // upload(File imageFile) async {
  //     // open a bytestream

  //   }

  Future<void> create(XFile xFile, String title, String description) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(server + "/api/image/"),
    );
    request.fields.addAll({
      'title': title,
      'description': description,
    });
    request.headers.addAll({"Content-type": "multipart/form-data"});
    http.MultipartFile file = http.MultipartFile(
      'file',
      xFile.readAsBytes().asStream(),
      await xFile.length(),
      filename: xFile.name,
      contentType: MediaType(
        xFile.mimeType!.split('/')[0],
        xFile.mimeType!.split('/')[1],
      ),
    );
    print(file.contentType);
    request.files.add(file);
    http.StreamedResponse res = await request.send();
    print(await res.stream.bytesToString());
    // __errorHandler(res.);
  }

  // Future<void> create(String title, String description, Image image) async {
  //   var formData = FormData();
  //   formData.append('file', MapEntry("Picture", await MultipartFile.fromFile(data.foto.path, filename: "pic-name.png"), ))

  //   http.Response res =
  //       await http.post(Uri.parse(server + "/api/folder"), body: {
  //     "title": title,
  //     "description": description,
  //     "file": image,
  //   });
  //   __errorHandler(jsonDecode(res.body));
  // }

  dynamic getAll() async {
    http.Response res = await http.get(Uri.parse(server + "/api/image"));
    return __errorHandler(jsonDecode(res.body));
  }
}
