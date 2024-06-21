import 'package:flutter_clean_bloc_arch/core/resources/data_state.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/entities/article.dart';

/// Abstract class defining the contract for article repository implementations.
abstract class ArticleRepository {
  /// Fetches news articles.
  ///
  /// Returns a [Future] of [DataState] containing a list of [ArticleEntity].
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
