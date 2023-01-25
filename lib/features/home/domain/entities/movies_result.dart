import 'package:flutter_bloc_example/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_result.freezed.dart';
part 'movies_result.g.dart';

@freezed
class MoviesResult with _$MoviesResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory MoviesResult({
    @JsonKey(name: 'page') required int currentPage,
    @JsonKey(name: 'results') @Default(<Movie>[]) List<Movie> movies,
    required int totalPages,
  }) = _MoviesResult;

  factory MoviesResult.fromJson(Map<String, dynamic> json) =>
      _$MoviesResultFromJson(json);
}
