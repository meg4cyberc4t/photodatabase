import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photodatabase/api/error.dart';

class PhotoDatabaseApi {
  static const String server = "http://db-learning.ithub.ru:1116";
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
}
