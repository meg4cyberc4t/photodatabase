class PhotoDatabaseApiError extends Error {
  PhotoDatabaseApiError(this.message);
  final String message;

  @override
  String toString() {
    return "PhotoDatabaseApiError: " + message;
  }
}
