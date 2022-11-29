import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/search_tv_bloc_test_helper.dart';

void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUp(
    () {
      mockSearchTvBloc = MockSearchTvBloc();
      registerFallbackValue(FakeSearchTvEvent());
      registerFallbackValue(FakeSearchTvState());
    },
  );

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testTv = Tv(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: const ["US"],
    genreIds: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final testTvList = [testTv];

  testWidgets(
    'Page should display center circular progress indicator when loading',
    (widgetTester) async {
      when(() => mockSearchTvBloc.state).thenReturn(SearchTvLoading());

      final progressIndicatorFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(makeTestableWidget(const TvSearchPage()));

      expect(centerFinder, findsWidgets);
      expect(progressIndicatorFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockSearchTvBloc.state)
          .thenReturn(SearchTvHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(makeTestableWidget(const TvSearchPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockSearchTvBloc.state)
          .thenReturn(const SearchTvError('Failed'));

      final textFinder = find.byType(Text);

      await widgetTester.pumpWidget(makeTestableWidget(const TvSearchPage()));

      expect(textFinder, findsWidgets);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display container when empty',
    (widgetTester) async {
      when(() => mockSearchTvBloc.state).thenReturn(SearchTvEmpty());

      final containerFinder = find.byType(Container);

      await widgetTester.pumpWidget(makeTestableWidget(const TvSearchPage()));

      expect(containerFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should be able to input text and scrollable until tv item is found',
    (widgetTester) async {
      when(() => mockSearchTvBloc.state)
          .thenReturn(SearchTvHasData(testTvList));

      await widgetTester.pumpWidget(makeTestableWidget(const TvSearchPage()));

      int index = 0;
      final textFieldFinder = find.byType(TextField);
      final scrollableFinder = find.byType(Scrollable);
      final tvItemFinder = find.byKey(ValueKey('tv_$index'));

      expect(textFieldFinder, findsOneWidget);

      await widgetTester.enterText(textFieldFinder, 'chainsawman');
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pump();

      await widgetTester.scrollUntilVisible(tvItemFinder, 500,
          scrollable: scrollableFinder.first);

      expect(tvItemFinder, findsOneWidget);
    },
  );
}
