import 'package:equatable/equatable.dart';

/// A class representing an article entity.
///
/// This class extends [Equatable] to provide value equality.
class ArticleEntity extends Equatable {
  /// The unique identifier of the article.
  final int? id;

  /// The author of the article.
  final String? author;

  /// The title of the article.
  final String? title;

  /// The description of the article.
  final String? description;

  /// The URL of the article.
  final String? url;

  /// The URL of the image associated with the article.
  final String? urlToImage;

  /// The publication date of the article.
  final String? publishedAt;

  /// The content of the article.
  final String? content;

  /// Constructs an [ArticleEntity] object.
  const ArticleEntity({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
