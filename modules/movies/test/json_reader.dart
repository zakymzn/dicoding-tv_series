import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  if (dir.endsWith('movies')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  if (dir.endsWith('modules')) {
    return File('$dir/movies/test/$name').readAsStringSync();
  }
  return File('$dir/modules/movies/test/$name').readAsStringSync();
}
