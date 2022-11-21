import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
