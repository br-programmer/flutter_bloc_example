part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.movies = const <Movie>[],
    this.status = HomeStatus.initial,
  });

  factory HomeState.initialState() => const HomeState();

  HomeState copyWith({
    List<Movie>? movies,
    HomeStatus? status,
  }) =>
      HomeState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
      );

  final List<Movie> movies;
  final HomeStatus status;

  @override
  List<Object?> get props => [movies, status];
}

extension HomeStateX on HomeState {
  bool get _moviesEmpty => movies.isEmpty;
  bool get _error => status == HomeStatus.error;
  bool get moviesLoading => status == HomeStatus.loading;
  bool get loading => moviesLoading && _moviesEmpty;
  bool get error => _error && _moviesEmpty;
  bool get errorLoadMoreMovie => _error && !_moviesEmpty;
}
