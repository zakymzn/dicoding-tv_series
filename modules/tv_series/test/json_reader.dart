import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;

  if (dir.endsWith('test')) {
    return File('$dir/$name').readAsStringSync();
  } else if (dir.endsWith('tv_series')) {
    return File('$dir/test/$name').readAsStringSync();
  } else if (dir.endsWith('modules')) {
    return File('$dir/tv_series/test/$name').readAsStringSync();
  } else {
    return File('$dir/modules/tv_series/test/$name').readAsStringSync();
  }
}
