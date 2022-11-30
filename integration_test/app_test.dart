import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:search/search.dart';
import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  group(
    'Testing app',
    () {
      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets(
        'start',
        (widgetTester) async {
          await binding.traceAction(() async {
            int movieIndex = 1;
            int recommendationIndex = 1;
            int seasonIndex = 0;
            int episodeIndex = 0;
            int tvIndex = 1;

            app.main();
            await widgetTester.pumpAndSettle();

            await widgetTester.tap(find.byKey(Key('search_movie')));
            await widgetTester.pumpAndSettle();
            expect(find.byType(MovieSearchPage), findsOneWidget);
            expect(find.byType(TextField), findsOneWidget);

            await widgetTester.enterText(find.byType(TextField), "naruto");
            await widgetTester.testTextInput
                .receiveAction(TextInputAction.done);
            await widgetTester.pumpAndSettle();

            final movieFinder = find.byKey(Key('movie_$movieIndex'));

            final scrollFinder = find.byType(Scrollable);

            await widgetTester.scrollUntilVisible(movieFinder, 500,
                scrollable: scrollFinder.last);
            expect(movieFinder, findsOneWidget);
            await widgetTester.tap(movieFinder);
            await widgetTester.pumpAndSettle();

            final backButton = find.byIcon(Icons.arrow_back);

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            await widgetTester.scrollUntilVisible(
                find.byKey(Key('top_rated_movies')), 500,
                scrollable: scrollFinder.first);
            await widgetTester.tap(find.byKey(Key('top_rated_movies')));
            await widgetTester.pumpAndSettle();

            await widgetTester.scrollUntilVisible(movieFinder, 500,
                scrollable: scrollFinder);
            expect(movieFinder, findsOneWidget);
            await widgetTester.tap(movieFinder);
            await widgetTester.pumpAndSettle();

            final addWatchlistButtonIcon = find.byIcon(Icons.add);

            expect(addWatchlistButtonIcon, findsOneWidget);
            await widgetTester.tap(addWatchlistButtonIcon);
            await widgetTester.pump(Duration(seconds: 1));
            expect(find.byType(SnackBar), findsOneWidget);
            expect(find.text('Added to Watchlist'), findsOneWidget);

            await widgetTester.pump(Duration(seconds: 5));

            final checkWatchlistButtonIcon = find.byIcon(Icons.check);

            expect(checkWatchlistButtonIcon, findsOneWidget);
            await widgetTester.tap(checkWatchlistButtonIcon);
            await widgetTester.pump(Duration(seconds: 1));
            expect(find.byType(SnackBar), findsOneWidget);
            expect(find.text('Removed from Watchlist'), findsOneWidget);

            final listFinder = find.byType(ListView);

            await widgetTester.scrollUntilVisible(listFinder, 500,
                scrollable: scrollFinder.first);
            expect(listFinder, findsOneWidget);

            final recommendationFinder =
                find.byKey(ValueKey('recommendation_$recommendationIndex'));

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

            expect(find.byType(HomeMoviePage), findsOneWidget);

            final ScaffoldState movieScaffoldState =
                widgetTester.firstState(find.byType(Scaffold));

            movieScaffoldState.openDrawer();
            await widgetTester.pumpAndSettle();

            final movieIconFinder = find.byIcon(Icons.movie);
            final tvIconFinder = find.byIcon(Icons.tv);

            expect(movieIconFinder, findsOneWidget);
            expect(tvIconFinder, findsOneWidget);

            await widgetTester.tap(tvIconFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(HomeTvPage), findsOneWidget);

            await widgetTester.tap(find.byKey(ValueKey('search_tv')));
            await widgetTester.pumpAndSettle();
            expect(find.byType(TvSearchPage), findsOneWidget);
            expect(find.byType(TextField), findsOneWidget);

            await widgetTester.enterText(find.byType(TextField), "spiderman");
            await widgetTester.testTextInput
                .receiveAction(TextInputAction.done);
            await widgetTester.pumpAndSettle();

            final tvFinder = find.byKey(ValueKey('tv_$tvIndex'));

            await widgetTester.scrollUntilVisible(tvFinder, 500,
                scrollable: scrollFinder.last);
            expect(tvFinder, findsOneWidget);
            await widgetTester.tap(tvFinder);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            await widgetTester.scrollUntilVisible(
                find.byKey(Key('top_rated_tv')), 500,
                scrollable: scrollFinder.first);
            await widgetTester.tap(find.byKey(Key('top_rated_tv')));
            await widgetTester.pumpAndSettle();

            expect(find.byType(TopRatedTvPage), findsOneWidget);

            await widgetTester.scrollUntilVisible(tvFinder, 500,
                scrollable: scrollFinder);
            expect(tvFinder, findsOneWidget);
            await widgetTester.tap(tvFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TvDetailPage), findsOneWidget);

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

            await widgetTester.scrollUntilVisible(recommendationFinder, 500,
                scrollable: scrollFinder.last);
            expect(recommendationFinder, findsOneWidget);
            await widgetTester.tap(recommendationFinder);
            await widgetTester.pumpAndSettle();

            final seasonFinder = find.byKey(ValueKey('season_$seasonIndex'));

            await widgetTester.scrollUntilVisible(seasonFinder, 500,
                scrollable: scrollFinder.at(1));
            expect(seasonFinder, findsOneWidget);
            await widgetTester.tap(seasonFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TvSeasonDetailPage), findsOneWidget);

            final episodeFinder =
                find.byKey(ValueKey('tv_episode_$episodeIndex'));

            await widgetTester.scrollUntilVisible(episodeFinder, 500,
                scrollable: scrollFinder.at(1));
            expect(episodeFinder, findsOneWidget);
            await widgetTester.tap(episodeFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TvEpisodeDetailPage), findsOneWidget);

            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TvSeasonDetailPage), findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TvDetailPage), findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(find.byType(TopRatedTvPage), findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(find.byType(HomeTvPage), findsOneWidget);

            final ScaffoldState tvScaffoldState =
                widgetTester.firstState(find.byType(Scaffold));

            tvScaffoldState.openDrawer();
            await widgetTester.pumpAndSettle();

            final watchlistIconFinder = find.byIcon(Icons.save_alt);

            expect(watchlistIconFinder, findsOneWidget);
            await widgetTester.tap(watchlistIconFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(WatchListPage), findsOneWidget);
            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            final aboutIconFinder = find.byIcon(Icons.info_outline);

            expect(aboutIconFinder, findsOneWidget);
            await widgetTester.tap(aboutIconFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(AboutPage), findsOneWidget);
            expect(backButton, findsOneWidget);
            await widgetTester.tap(backButton);
            await widgetTester.pumpAndSettle();

            expect(movieIconFinder, findsOneWidget);
            await widgetTester.tap(movieIconFinder);
            await widgetTester.pumpAndSettle();

            expect(find.byType(HomeMoviePage), findsOneWidget);
          });
        },
      );
    },
  );
}
