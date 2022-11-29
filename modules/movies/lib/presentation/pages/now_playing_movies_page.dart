import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  const NowPlayingMoviesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingMoviesPage> createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingMoviesBloc>().add(OnNowPlayingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMoviesBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieListHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie, index);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
