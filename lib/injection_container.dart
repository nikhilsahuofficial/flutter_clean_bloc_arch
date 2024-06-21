import 'package:dio/dio.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/daily_news/data/data_sources/news_api_service.dart';

final sl = GetIt.instance;

/// Initializes all dependencies using GetIt for dependency injection.
///
/// This function registers various dependencies such as Dio for network requests,
/// data sources like NewsApiService, repository implementations, use cases,
/// and BLoCs for managing business logic.
Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
        sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetArticleUseCase(sl()));

  // Blocs
  sl.registerFactory(() => RemoteArticlesBloc(sl()));
}
