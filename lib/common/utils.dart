import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

typedef OnObservation = void Function(Route route, Route? previousRoute);

class TestNavigatorObserver extends NavigatorObserver {
  OnObservation? onPushed;
  OnObservation? onPopped;
  OnObservation? onRemoved;
  OnObservation? onReplaced;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (onPushed != null) {
      onPushed!(route, previousRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (onPopped != null) {
      onPopped!(route, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (onRemoved != null) {
      onRemoved!(route, previousRoute);
    }
  }

  @override
  void didReplace({Route? oldRoute, Route? newRoute}) {
    if (onReplaced != null) {
      onReplaced!(newRoute!, oldRoute);
    }
  }

  attachPushRouteObserver(String expectedRouteName, Function pushCallback) {
    onPushed = (route, previousRoute) {
      final isExpectedRoutePushed = route.settings.name == expectedRouteName;

      if (isExpectedRoutePushed) {
        pushCallback();
      }
    };
  }

  attachPushRouteObserverWithArgs(
      String expectedRouteName, VoidCallback pushCallback(Object args)) {
    onPushed = (route, previousRoute) {
      final isExpectedRoutePushed = route.settings.name == expectedRouteName;

      if (isExpectedRoutePushed) {
        pushCallback(route.settings.arguments!);
      }
    };
  }
}
