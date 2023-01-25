import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/bloc/theme_bloc.dart';
import 'package:flutter_bloc_example/core/extensions/string_x.dart';
import 'package:flutter_bloc_example/features/home/home.dart';
import 'package:flutter_bloc_example/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        late String text;
        if (state.dark) {
          text = 'Dark Theme';
        } else {
          text = 'Light Theme';
        }
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(text)));
      },
      child: BlocProvider(
        create: (_) => HomeBloc(context.read())
          ..init()
          ..add(HomeEvent.onFecthMovies()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Movies'),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => themeBloc.add(ThemeEvent.onChangeTheme()),
                icon: const Icon(Icons.offline_bolt),
              ),
            ],
          ),
          body: const _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error) {
          return const Center(child: Text('Error load movies'));
        }
        final movies = state.movies;
        return RefreshIndicator(
          onRefresh: () {
            homeBloc.add(HomeEvent.onFecthMovies(refresh: true));
            return Future.value();
          },
          child: ListView.builder(
            itemCount: movies.length,
            controller: homeBloc.scrollController,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                homeBloc.add(
                  HomeEvent.onChangeNameMovie(
                    newTitle: 'Change Title',
                    index: index,
                  ),
                );
              },
              child: _MovieItem(movie: movies[index]),
            ),
          ),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Image.network(movie.backdropPath?.image ?? ''),
            Center(
              child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Text(
                  movie.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
