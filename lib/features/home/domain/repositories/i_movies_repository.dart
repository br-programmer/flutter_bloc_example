import 'package:flutter_bloc_example/features/features.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> fetchMovies({required int page, String? language});
  Stream<String> get onNewMovie;
}
