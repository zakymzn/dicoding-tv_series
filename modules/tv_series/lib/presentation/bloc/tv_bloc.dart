import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/get_tv_episode_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_season_detail.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvBloc(this.getNowPlayingTv) : super(TvEmpty()) {
    on<OnNowPlayingTv>((event, emit) async {
      emit(TvLoading());

      final getNowPlayingTvResult = await getNowPlayingTv.execute();

      getNowPlayingTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(TvEmpty()) {
    on<OnPopularTv>((event, emit) async {
      emit(TvLoading());

      final getPopularTvResult = await getPopularTv.execute();

      getPopularTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {
      emit(TvLoading());

      final getTopRatedTvResult = await getTopRatedTv.execute();

      getTopRatedTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class TvRecommendationsBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationsBloc(this.getTvRecommendations) : super(TvEmpty()) {
    on<OnTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final getTvRecommendationsResult = await getTvRecommendations.execute(id);

      getTvRecommendationsResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tv) => emit(
          TvListHasData(tv),
        ),
      );
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(TvEmpty()) {
    on<OnTvDetail>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final getTvDetailResult = await getTvDetail.execute(id);

      getTvDetailResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tv) => emit(
          TvDetailHasData(tv),
        ),
      );
    });
  }
}

class TvSeasonDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailBloc(this.getTvSeasonDetail) : super(TvEmpty()) {
    on<OnTvSeasonDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(TvLoading());

      final getTvSeasonDetailresult =
          await getTvSeasonDetail.execute(id, seasonNumber);

      getTvSeasonDetailresult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvSeason) => emit(
          TvSeasonDetailHasData(tvSeason),
        ),
      );
    });
  }
}

class TvEpisodeDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvEpisodeDetail getTvEpisodeDetail;

  TvEpisodeDetailBloc(this.getTvEpisodeDetail) : super(TvEmpty()) {
    on<OnTvEpisodeDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      final episodeNumber = event.episodeNumber;

      emit(TvLoading());

      final getTvEpisodeDetailresult =
          await getTvEpisodeDetail.execute(id, seasonNumber, episodeNumber);

      getTvEpisodeDetailresult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvEpisode) => TvEpisodeDetailHasData(tvEpisode),
      );
    });
  }
}

class TvWatchlistBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTv getWatchlistTv;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
    this.getTvWatchListStatus,
    this.getWatchlistTv,
    this.removeTvWatchlist,
    this.saveTvWatchlist,
  ) : super(TvEmpty()) {
    on<OnTvWatchlist>((event, emit) async {
      emit(TvLoading());

      final getTvWatchlistResult = await getWatchlistTv.execute();

      getTvWatchlistResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (data) => emit(
          TvListHasData(data),
        ),
      );
    });

    on<OnTvWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final getTvWatchlistStatusResult = await getTvWatchListStatus.execute(id);
      emit(TvWatchlistStatus(getTvWatchlistStatusResult));
    });

    on<OnAddTvWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      emit(TvLoading());

      final getAddTvWatchlistResult = await saveTvWatchlist.execute(tv);

      getAddTvWatchlistResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (successMessage) => emit(
          TvWatchlistMessage(successMessage),
        ),
      );
    });

    on<OnRemoveTvWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      emit(TvLoading());

      final getRemoveTvWatchlistResult = await removeTvWatchlist.execute(tv);

      getRemoveTvWatchlistResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (successMessage) => emit(
          TvWatchlistMessage(successMessage),
        ),
      );
    });
  }
}
