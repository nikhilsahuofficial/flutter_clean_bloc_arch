import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_bloc_arch/core/constants/constants.dart';
import 'package:flutter_clean_bloc_arch/core/resources/data_state.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/data/data_sources/news_api_service.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Implementation of the [ArticleRepository] interface.
class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  /// Constructs an [ArticleRepositoryImpl] with the given [NewsApiService].
  ArticleRepositoryImpl(this._newsApiService);

  /// Fetches news articles from the News API.
  ///
  /// Returns a [DataState] containing either a list of [ArticleModel] on success
  /// or a [DioException] on failure.
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: dotenv.env['API_KEY'],
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
