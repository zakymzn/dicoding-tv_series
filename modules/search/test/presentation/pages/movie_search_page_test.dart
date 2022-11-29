import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/search_movie_bloc_test_helper.dart';

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;

  setUp(
    () {
      mockSearchMoviesBloc = MockSearchMoviesBloc();
      registerFallbackValue(FakeSearchMoviesEvent());
      registerFallbackValue(FakeSearchMoviesState());
    },
  );

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMoviesBloc>.value(
      value: mockSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  testWidgets(
    'Page should display center circular progress indicator when loading',
    (widgetTester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchMoviesLoading());

      final progressIndicatorFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester
          .pumpWidget(makeTestableWidget(const MovieSearchPage()));

      expect(centerFinder, findsWidgets);
      expect(progressIndicatorFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchMoviesHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await widgetTester
          .pumpWidget(makeTestableWidget(const MovieSearchPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(const SearchMoviesError('Failed'));

      final textFinder = find.byType(Text);

      await widgetTester
          .pumpWidget(makeTestableWidget(const MovieSearchPage()));

      expect(textFinder, findsWidgets);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display container when empty',
    (widgetTester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchMoviesEmpty());

      final containerFinder = find.byType(Container);

      await widgetTester
          .pumpWidget(makeTestableWidget(const MovieSearchPage()));

      expect(containerFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should be able to input text and scrollable until movie item is found',
    (widgetTester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchMoviesHasData(testMovieList));

      await widgetTester
          .pumpWidget(makeTestableWidget(const MovieSearchPage()));

      int index = 0;
      final textFieldFinder = find.byType(TextField);
      final scrollableFinder = find.byType(Scrollable);
      final movieItemFinder = find.byKey(ValueKey('movie_$index'));

      expect(textFieldFinder, findsOneWidget);

      await widgetTester.enterText(textFieldFinder, 'spiderman');
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pump();

      await widgetTester.scrollUntilVisible(movieItemFinder, 500,
          scrollable: scrollableFinder.first);

      expect(movieItemFinder, findsOneWidget);
    },
  );
}
