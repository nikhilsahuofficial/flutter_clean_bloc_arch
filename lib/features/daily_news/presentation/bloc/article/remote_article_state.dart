import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/domain/entities/article.dart';

/// Abstract base class for states related to remote articles.
abstract class RemoteArticlesState extends Equatable {
  /// List of articles fetched from remote source.
  final List<ArticleEntity>? articles;

  /// Error encountered while fetching articles.
  final DioException? error;

  const RemoteArticlesState({this.articles, this.error});

  @override
  List<Object?> get props => [articles, error];
}

/// State indicating that remote articles are currently being fetched.
class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

/// State indicating that remote articles have been successfully fetched.
class RemoteArticlesDone extends RemoteArticlesState {
  /// List of articles fetched successfully.
  final List<ArticleEntity> articles;

  const RemoteArticlesDone({required this.articles})
      : super(articles: articles);

  @override
  List<Object?> get props => [articles];
}

/// State indicating that an error occurred while fetching remote articles.
class RemoteArticlesError extends RemoteArticlesState {
  /// The error that occurred.
  final DioException error;

  const RemoteArticlesError({required this.error}) : super(error: error);

  @override
  List<Object?> get props => [error];
}
