import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class MultiArgument {
  final int arg1;
  final int arg2;

  MultiArgument(
    this.arg1,
    this.arg2,
  );
}

class TripleArgument {
  final int arg1;
  final int arg2;
  final int arg3;

  TripleArgument(
    this.arg1,
    this.arg2,
    this.arg3,
  );
}
