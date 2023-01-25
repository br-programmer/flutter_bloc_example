part of 'home_bloc.dart';

abstract class HomeEvent {
  factory HomeEvent.onFecthMovies({bool refresh = false}) =>
      _FetchMovies(refresh);

  factory HomeEvent.onChangeNameMovie({
    required String newTitle,
    required int index,
  }) =>
      _ChangeNameMovie(newTitle, index);
}

class _FetchMovies implements HomeEvent {
  const _FetchMovies(this.refresh);
  final bool refresh;
}

class _ChangeNameMovie implements HomeEvent {
  const _ChangeNameMovie(this.newTitle, this.index);

  final String newTitle;
  final int index;
}
