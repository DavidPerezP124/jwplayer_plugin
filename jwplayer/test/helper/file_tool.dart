import 'dart:convert';
import 'dart:io';

class FileError extends Error {
  final String? message;
  FileError(String this.message);
  @override
  String toString() => "File Error: $message";
}

class FileNotFoundError extends Error implements FileError {
  @override
  final String? message;
  FileNotFoundError([this.message]);
  @override
  String toString() {
    var message = this.message;
    return (message != null) ? "File not found: $message" : "File not Found";
  }
}

/// Used to get files to test.
class TestFile {
  late File file;

  /// Returns a file or throws an error if there is no such file.
  TestFile searchFile(String path) {
    file = File(path);
    if (!file.existsSync()) {
      throw FileNotFoundError("File does not exist at path: $path");
    }
    return this;
  }

  dynamic asJSON() {
    if (!file.existsSync()) {
      throw FileNotFoundError("File does not exist");
    }
    dynamic json = jsonDecode(file.readAsStringSync());
    return json;
  }
}
