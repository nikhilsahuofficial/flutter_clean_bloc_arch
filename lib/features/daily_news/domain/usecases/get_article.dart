import 'package:flutter_clean_bloc_arch/core/resources/data_state.dart';
import 'package:flutter_clean_bloc_arch/core/usecase/usecase.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/repository/article_repository.dart';

/// Use case responsible for fetching news articles.
class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  /// Constructs a [GetArticleUseCase] with the provided [ArticleRepository].
  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
