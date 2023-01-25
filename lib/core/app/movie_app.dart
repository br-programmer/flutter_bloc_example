import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/bloc/theme_bloc.dart';
import 'package:flutter_bloc_example/features/features.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IMoviesRepository>(
          create: (_) => MoviesRepository(),
        ),
      ],
      child: BlocProvider(
        create: (_) => ThemeBloc(),
        child: Builder(
          builder: (context) => BlocBuilder<ThemeBloc, ThemeState>(
            builder: (_, state) => MaterialApp(
              title: 'Super Cines',
              theme: state.dark ? ThemeData.dark() : ThemeData.light(),
              home: const HomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
