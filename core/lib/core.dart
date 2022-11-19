library core;

export 'styles/colors.dart';
export 'styles/text_styles.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/ssl_pinning.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';

export 'data/datasources/db/database_helper.dart';

export 'data/datasources/movie/movie_local_data_source.dart';
export 'data/datasources/movie/movie_remote_data_source.dart';

export 'data/datasources/tv/tv_local_data_source.dart';
export 'data/datasources/tv/tv_remote_data_source.dart';

export 'data/models/created_by_model.dart';
export 'data/models/genre_model.dart';
export 'data/models/last_episode_to_air_model.dart';
export 'data/models/season_model.dart';

export 'data/models/movie/movie_detail_model.dart';
export 'data/models/movie/movie_model.dart';
export 'data/models/movie/movie_response.dart';
export 'data/models/movie/movie_table.dart';

export 'data/models/tv/tv_detail_model.dart';
export 'data/models/tv/tv_model.dart';
export 'data/models/tv/tv_response.dart';
export 'data/models/tv/tv_table.dart';

export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_repository_impl.dart';

export 'domain/entities/genre.dart';
export 'domain/entities/last_episode_to_air.dart';
export 'domain/entities/season.dart';

export 'domain/entities/movie/movie.dart';
export 'domain/entities/movie/movie_detail.dart';

export 'domain/entities/tv/tv.dart';
export 'domain/entities/tv/tv_detail.dart';

export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_repository.dart';

export 'domain/usecases/movie/get_movie_detail.dart';
export 'domain/usecases/movie/get_movie_recommendations.dart';
export 'domain/usecases/movie/get_movie_watchlist_status.dart';
export 'domain/usecases/movie/get_now_playing_movies.dart';
export 'domain/usecases/movie/get_popular_movies.dart';
export 'domain/usecases/movie/get_top_rated_movies.dart';
export 'domain/usecases/movie/get_watchlist_movies.dart';
export 'domain/usecases/movie/remove_movie_watchlist.dart';
export 'domain/usecases/movie/save_movie_watchlist.dart';

export 'domain/usecases/tv/get_now_playing_tv.dart';
export 'domain/usecases/tv/get_popular_tv.dart';
export 'domain/usecases/tv/get_top_rated_tv.dart';
export 'domain/usecases/tv/get_tv_detail.dart';
export 'domain/usecases/tv/get_tv_recommendations.dart';
export 'domain/usecases/tv/get_tv_watchlist_status.dart';
export 'domain/usecases/tv/get_watchlist_tv.dart';
export 'domain/usecases/tv/remove_tv_watchlist.dart';
export 'domain/usecases/tv/save_tv_watchlist.dart';

export 'presentation/pages/movie/home_movie_page.dart';
export 'presentation/pages/movie/movie_detail_page.dart';
export 'presentation/pages/movie/now_playing_movies_page.dart';
export 'presentation/pages/movie/popular_movies_page.dart';
export 'presentation/pages/movie/top_rated_movies_page.dart';
export 'presentation/pages/movie/watchlist_movies_page.dart';

export 'presentation/pages/tv/home_tv_page.dart';
export 'presentation/pages/tv/now_playing_tv_page.dart';
export 'presentation/pages/tv/popular_tv_page.dart';
export 'presentation/pages/tv/top_rated_tv_page.dart';
export 'presentation/pages/tv/tv_detail_page.dart';
export 'presentation/pages/tv/watchlist_tv_page.dart';

export 'presentation/pages/watchlist_page.dart';

export 'presentation/provider/movie/movie_detail_notifier.dart';
export 'presentation/provider/movie/movie_list_notifier.dart';
export 'presentation/provider/movie/now_playing_movies_notifier.dart';
export 'presentation/provider/movie/popular_movies_notifier.dart';
export 'presentation/provider/movie/top_rated_movies_notifier.dart';
export 'presentation/provider/movie/watchlist_movie_notifier.dart';

export 'presentation/provider/tv/now_playing_tv_notifier.dart';
export 'presentation/provider/tv/popular_tv_notifier.dart';
export 'presentation/provider/tv/top_rated_tv_notifier.dart';
export 'presentation/provider/tv/tv_detail_notifier.dart';
export 'presentation/provider/tv/tv_list_notifier.dart';
export 'presentation/provider/tv/watchlist_tv_notifier.dart';

export 'presentation/provider/watchlist_navigation_bar_notifier.dart';

export 'presentation/widgets/movie_card_list.dart';
export 'presentation/widgets/tv_card_list.dart';
