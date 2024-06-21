import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc_arch/core/resources/data_state.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/presentation/bloc/article/remote_article_event.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/presentation/bloc/article/remote_article_state.dart';

/// Bloc responsible for managing remote articles.
class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;

  /// Constructs a [RemoteArticlesBloc] with the provided [GetArticleUseCase].
  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  /// Handles the [GetArticles] event to fetch articles.
  Future<void> onGetArticles(
      GetArticles event, Emitter<RemoteArticlesState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(articles: dataState.data!));
    }

    if (dataState is DataFailed) {
      debugPrint(dataState.error.toString());
      emit(RemoteArticlesError(error: dataState.error!));
    }
  }
}
