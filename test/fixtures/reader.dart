import 'dart:io';

String reader(String file) =>
    File('test/fixtures/jsons/$file').readAsStringSync();
