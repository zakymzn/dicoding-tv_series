import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeasonDetailPage extends StatefulWidget {
  final int id;
  final int seasonNumber;

  const TvSeasonDetailPage({
    Key? key,
    required this.id,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  State<TvSeasonDetailPage> createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeasonDetailBloc>().add(
            OnTvSeasonDetail(
              widget.id,
              widget.seasonNumber,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Season Detail'),
      ),
      body: BlocBuilder<TvSeasonDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeasonDetailHasData) {
            final tvSeason = state.result;

            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeason.posterPath}',
                  width: screenWidth,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: kDavysGrey,
                    child: Icon(Icons.image_not_supported, size: 100),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 56),
                  child: DraggableScrollableSheet(
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: kRichBlack,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        padding: EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  tvSeason.name,
                                  style: kHeading5,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(tvSeason.overview),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Episode List',
                                style: kHeading6,
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tvSeason.episodes.length,
                                  itemBuilder: (context, index) {
                                    final tvEpisode = tvSeason.episodes[index];
                                    if (tvEpisode.stillPath != null) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              TV_EPISODE_DETAIL_ROUTE,
                                              arguments: TripleArgument(
                                                  widget.id,
                                                  widget.seasonNumber,
                                                  tvEpisode.episodeNumber),
                                            );
                                          },
                                          splashColor: kDavysGrey,
                                          child: Stack(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: SizedBox(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$BASE_IMAGE_URL${tvEpisode.stillPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      height: 150,
                                                      width: 250,
                                                      color: kDavysGrey,
                                                      child: Icon(Icons
                                                          .image_not_supported),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration:
                                                    BoxDecoration(boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    blurRadius: 15,
                                                  )
                                                ]),
                                                child: Text(
                                                  'Episode ${tvEpisode.episodeNumber}',
                                                  style: kHeading6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}