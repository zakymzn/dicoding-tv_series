part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingTv extends TvEvent {}

class OnPopularTv extends TvEvent {}

class OnTopRatedTv extends TvEvent {}

class OnTvRecommendations extends TvEvent {
  final int id;
  OnTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvDetail extends TvEvent {
  final int id;
  OnTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvWatchlist extends TvEvent {}

class OnTvWatchlistStatus extends TvEvent {
  final int id;
  OnTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  OnAddTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  OnRemoveTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
