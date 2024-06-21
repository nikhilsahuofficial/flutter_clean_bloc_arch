import 'package:dio/dio.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/data/models/article.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/constants.dart';

part 'news_api_service.g.dart';

/// A service that defines methods for interacting with the News API.
@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  /// Factory constructor for creating an instance of [NewsApiService].
  factory NewsApiService(Dio dio) = _NewsApiService;

  /// Fetches the top headlines from the News API.
  ///
  /// [apiKey]: Your API key for authenticating the request.
  /// [country]: The country for which to get headlines.
  /// [category]: The category for which to get headlines.
  ///
  /// Returns a [Future] that resolves to an [HttpResponse] containing a list of [ArticleModel].
  @GET('top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
