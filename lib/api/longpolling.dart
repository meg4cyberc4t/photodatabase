import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photodatabase/api/methods.dart';

class PhotoDatabaseLongPoolingApi {
  static const String server = "http://db-learning.ithub.ru:1116";
  static Stream getAllFolders([String? lastStateHash]) async* {
    while (true) {
      try {
        http.Response res = await http.get(
            Uri.parse(server + "/lp/folder/?last_state_hash=$lastStateHash"));
        var data = errorMiddleware(jsonDecode(res.body));
        lastStateHash = data['hash'];
        yield data['state'];
      } catch (_) {
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }
}