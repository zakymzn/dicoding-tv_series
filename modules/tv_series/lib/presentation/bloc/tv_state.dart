part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvError extends TvState {
  final String message;

  TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvListHasData extends TvState {
  final List<Tv> result;

  TvListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvDetailHasData extends TvState {
  final TvDetail result;

  TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvWatchlistMessage extends TvState {
  final String message;

  TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistStatus extends TvState {
  final bool status;

  TvWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}
