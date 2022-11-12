import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  group(
    'Testing app',
    () {
      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets(
        'movies test',
        (widgetTester) async {
          await binding.traceAction(() async {
            int movieIndex = 10;
            int recommendationIndex = 10;
            final addWatchlistButtonIcon = find.byIcon(Icons.add);
            final checkWatchlistButtonIcon = find.byIcon(Icons.check);
            final backButton = find.byIcon(Icons.arrow_back);
            final movieFinder = find.byKey(Key('movie_$movieIndex'));
            final recommendationFinder =
                find.byKey(ValueKey('recommendation_$recommendationIndex'));
            final scrollFinder = find.byType(Scrollable);
            final listFinder = find.byType(ListView);

            app.main();
            await widgetTester.pumpAndSettle();

            await widgetTester.tap(find.byKey(Key('search_movie')));
            await widgetTester.pumpAndSettle();
            expect(find.byType(TextField), findsOneWidget);

            await widgetTester.enterText(find.byType(TextField), "spiderman");
            await widgetTester.testTextInput
                .receiveAction(TextInputAction.done);
            await widgetTester.pumpAndSettle();

            await widgetTester.scrollUntilVisible(movieFinder, 500,
                scrollable: scrollFinder.last);
            expect(movieFinder, findsOneWidget);
            await widgetTester.tap(movieFinder);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            await widgetTester.tap(find.byKey(Key('now_playing_movies')));
            await widgetTester.pumpAndSettle();

            await widgetTester.scrollUntilVisible(movieFinder, 500,
                scrollable: scrollFinder);
            expect(movieFinder, findsOneWidget);
            await widgetTester.tap(movieFinder);
            await widgetTester.pumpAndSettle();

            expect(addWatchlistButtonIcon, findsOneWidget);
            await widgetTester.tap(addWatchlistButtonIcon);
            await widgetTester.pump(Duration(seconds: 1));
            expect(find.byType(SnackBar), findsOneWidget);
            expect(find.text('Added to Watchlist'), findsOneWidget);

            await widgetTester.pump(Duration(seconds: 5));

            expect(checkWatchlistButtonIcon, findsOneWidget);
            await widgetTester.tap(checkWatchlistButtonIcon);
            await widgetTester.pump(Duration(seconds: 1));
            expect(find.byType(SnackBar), findsOneWidget);
            expect(find.text('Removed from Watchlist'), findsOneWidget);

            await widgetTester.scrollUntilVisible(listFinder, 500,
                scrollable: scrollFinder.first);
            expect(listFinder, findsOneWidget);

            await widgetTester.scrollUntilVisible(recommendationFinder, 500,
                scrollable: scrollFinder.last);
            expect(recommendationFinder, findsOneWidget);
            await widgetTester.tap(recommendationFinder);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();
          });
        },
      );
    },
  );
}
