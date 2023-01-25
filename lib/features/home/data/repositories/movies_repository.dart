import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/features/features.dart';

class MoviesRepository implements IMoviesRepository {
  MoviesRepository()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3/',
            queryParameters: {'api_key': Constants.apiKey},
          ),
        );

  final Dio _dio;

  StreamController<String>? _streamController;

  @override
  Future<MoviesResult> fetchMovies({
    required int page,
    String? language,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'movie/now_playing',
        queryParameters: {
          'page': page,
          if (language != null) 'language': language,
        },
      );
      final data = response.data;
      if (data != null) {
        if (_streamController != null) {
          _streamController!.add('New Page Load');
        }
        return MoviesResult.fromJson(data);
      }
      throw Exception('data is null');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<String> get onNewMovie {
    _streamController ??= StreamController.broadcast();
    return _streamController!.stream;
  }
}
