import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tv.dart';

import 'search_tv_event.dart';
import 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;

  SearchTvBloc(this._searchTv) : super(SearchTvEmpty()) {
    on<OnTvQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvLoading());

        final result = await _searchTv.execute(query);

        result.fold(
          (failure) {
            emit(SearchTvError(failure.message));
          },
          (data) {
            emit(SearchTvHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}
