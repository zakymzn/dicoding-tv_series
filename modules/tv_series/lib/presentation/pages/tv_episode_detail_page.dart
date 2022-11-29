import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvEpisodeDetailPage extends StatefulWidget {
  final int id;
  final int seasonNumber;
  final int episodeNumber;

  const TvEpisodeDetailPage({
    Key? key,
    required this.id,
    required this.seasonNumber,
    required this.episodeNumber,
  }) : super(key: key);

  @override
  State<TvEpisodeDetailPage> createState() => _TvEpisodeDetailPageState();
}

class _TvEpisodeDetailPageState extends State<TvEpisodeDetailPage> {
  List<bool> boolExpand = [
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvEpisodeDetailBloc>().add(
            OnTvEpisodeDetail(
              widget.id,
              widget.seasonNumber,
              widget.episodeNumber,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Episode ${widget.episodeNumber}'),
      ),
      body: BlocBuilder<TvEpisodeDetailBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvEpisodeDetailHasData) {
            final tvEpisode = state.result;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${tvEpisode.stillPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 150,
                      width: screenWidth,
                      color: kDavysGrey,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          tvEpisode.name,
                          style: kHeading5,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text('Air Date : ${tvEpisode.airDate}'),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: tvEpisode.voteAverage / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 24,
                            ),
                            Text('${tvEpisode.voteAverage}'),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Overview',
                          style: kHeading6,
                        ),
                        Text(
                          tvEpisode.overview,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ExpansionPanelList(
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              boolExpand[panelIndex] = !isExpanded;
                            });
                          },
                          dividerColor: kMikadoYellow,
                          animationDuration: const Duration(milliseconds: 500),
                          children: [
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(
                                    'Guest Stars',
                                    style: kHeading6,
                                  ),
                                );
                              },
                              isExpanded: boolExpand[0],
                              canTapOnHeader: true,
                              body: MasonryGridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: tvEpisode.guestStars.length,
                                itemBuilder: (context, index) {
                                  final guestStar = tvEpisode.guestStars[index];

                                  return Padding(
                                    key: Key('guest_star_$index'),
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        color: kGrey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '$BASE_IMAGE_URL${guestStar.profilePath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                height: 150,
                                                width: screenWidth,
                                                color: kDavysGrey,
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  size: 100,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    guestStar.name,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    guestStar.character,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(
                                    'Crew',
                                    style: kHeading6,
                                  ),
                                );
                              },
                              isExpanded: boolExpand[1],
                              canTapOnHeader: true,
                              body: MasonryGridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: tvEpisode.crew.length,
                                itemBuilder: (context, index) {
                                  final crew = tvEpisode.crew[index];

                                  return Padding(
                                    key: Key('crew_$index'),
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        color: kGrey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '$BASE_IMAGE_URL${crew.profilePath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                height: 150,
                                                width: screenWidth,
                                                color: kDavysGrey,
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  size: 100,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    crew.name,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    crew.department,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    crew.job,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}
