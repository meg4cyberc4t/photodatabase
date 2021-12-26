import 'package:photodatabase/api/error.dart';

errorMiddleware(out) {
  if (out is Map) {
    if (out.containsKey('error')) {
      throw PhotoDatabaseApiError(out['error']);
    }
  }
  return out;
}
