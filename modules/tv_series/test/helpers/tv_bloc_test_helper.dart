import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/tv_bloc.dart';

class FakeTvState extends Fake implements TvState {}

class FakeTvEvent extends Fake implements TvEvent {}

class MockNowPlayingTvBloc extends MockBloc<TvEvent, TvState>
    implements NowPlayingTvBloc {}

class MockPopularTvBloc extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

class MockTopRatedTvBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

class MockTvDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class MockTvSeasonDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvSeasonDetailBloc {}

class MockTvEpisodeDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvEpisodeDetailBloc {}

class MockTvRecommendationsBloc extends MockBloc<TvEvent, TvState>
    implements TvRecommendationsBloc {}

class MockTvWatchlistBloc extends MockBloc<TvEvent, TvState>
    implements TvWatchlistBloc {}
