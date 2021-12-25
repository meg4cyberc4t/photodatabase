import 'package:photodatabase/api/error.dart';

errorMiddleware(out) {
  if (out.containsKey('error')) {
    throw PhotoDatabaseApiError(out['error']);
  }
  return out;
}
