import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  TvDetailPage({required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(OnTvDetail(widget.id));
    context.read<TvRecommendationsBloc>().add(OnTvRecommendations(widget.id));
    context.read<TvWatchlistBloc>().add(OnTvWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.result;
            final tvRecommendations = context
                .select<TvRecommendationsBloc, List<Tv>>(
                    (TvRecommendationsBloc result) {
              final state = result.state;
              return state is TvListHasData ? state.result : [];
            });
            final isAddedToWatchlist =
                context.select<TvWatchlistBloc, bool>((TvWatchlistBloc result) {
              final state = result.state;
              return state is TvWatchlistStatus ? state.status : false;
            });
            return SafeArea(
              child: TvDetailContent(
                tv,
                tvRecommendations,
                isAddedToWatchlist,
              ),
            );
          } else {
            return Text('Failed');
          }
        },
      ),
    );
  }
}

class TvDetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  TvDetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tv.name,
                            style: kHeading5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!isAddedWatchlist) {
                                context
                                    .read<TvWatchlistBloc>()
                                    .add(OnAddTvWatchlist(tv));
                              } else {
                                context
                                    .read<TvWatchlistBloc>()
                                    .add(OnRemoveTvWatchlist(tv));
                              }

                              String message = !isAddedWatchlist
                                  ? TvWatchlistBloc.watchlistAddSuccessMessage
                                  : TvWatchlistBloc
                                      .watchlistRemoveSuccessMessage;

                              final state =
                                  BlocProvider.of<TvWatchlistBloc>(context)
                                      .state;

                              if (state is MovieListHasData) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(message),
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(message),
                                    );
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isAddedWatchlist
                                    ? Icon(Icons.check)
                                    : Icon(Icons.add),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                          Text(
                            _showGenres(tv.genres),
                          ),
                          Row(
                            children: [
                              Text('Last episode : '),
                              Text(
                                '${tv.lastEpisodeToAir.episodeNumber}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Number of episode : '),
                              Text(
                                '${tv.numberOfEpisodes}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Season : '),
                              Text(
                                '${tv.seasons.map((e) => e.seasonNumber).first}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: tv.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${tv.voteAverage}')
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Overview',
                            style: kHeading6,
                          ),
                          Text(
                            tv.overview,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Recommendations',
                            style: kHeading6,
                          ),
                          BlocBuilder<TvDetailBloc, TvState>(
                            builder: (context, state) {
                              if (state is TvLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TvError) {
                                return Text(state.message);
                              } else if (state is TvListHasData) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = recommendations[index];
                                      return Padding(
                                        key: Key('recommendation_$index'),
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TV_DETAIL_ROUTE,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: recommendations.length,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: 4,
                      width: 48,
                    ),
                  )
                ]),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
