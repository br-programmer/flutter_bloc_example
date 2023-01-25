import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/features/features.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._moviesRepository) : super(HomeState.initialState()) {
    on<_FetchMovies>(_fetchMoviesToState);
    on<_ChangeNameMovie>(_changeNameMovieToState);
  }

  final IMoviesRepository _moviesRepository;

  late final ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  late StreamSubscription<String> _subscription;

  void init() {
    _scrollController = ScrollController()..addListener(_listener);
    _subscription = _moviesRepository.onNewMovie.listen(_newMovieListener);
  }

  var _page = 1;
  var _hasNextPage = true;

  void _listener() {
    final position = _scrollController.position;
    final maxScrollExtent = position.maxScrollExtent;
    final pixel = position.pixels + 40;
    final hasPaginate = pixel >= maxScrollExtent && _hasNextPage;
    if (hasPaginate && !state.moviesLoading) {
      add(HomeEvent.onFecthMovies());
    }
  }

  Future<void> _fetchMoviesToState(
    _FetchMovies event,
    Emitter<HomeState> emit,
  ) async {
    final refresh = event.refresh;
    emit(state.copyWith(status: HomeStatus.loading));
    final movies = [...state.movies];
    if (refresh) {
      movies.clear();
      _page = 1;
    }
    try {
      emit(state.copyWith(movies: movies));
      final moviesResult = await _moviesRepository.fetchMovies(page: _page);
      movies.addAll(moviesResult.movies);
      _page = moviesResult.currentPage + 1;
      _hasNextPage = moviesResult.currentPage < moviesResult.totalPages;
      emit(state.copyWith(movies: movies, status: HomeStatus.success));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  @override
  Future<void> close() {
    _scrollController
      ..removeListener(_listener)
      ..dispose();
    _subscription.cancel();
    return super.close();
  }

  void _newMovieListener(String event) {
    if (kDebugMode) {
      print(event);
    }
  }

  void _changeNameMovieToState(
    _ChangeNameMovie event,
    Emitter<HomeState> emit,
  ) {
    final movies = [...state.movies];
    movies[event.index] = movies[event.index].copyWith(
      title: event.newTitle,
    );
    emit(state.copyWith(movies: movies));
  }
}
