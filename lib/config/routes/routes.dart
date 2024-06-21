import 'package:flutter/material.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/login/login.dart';

/// A class to manage application routes.
class AppRoutes {
  /// Generates routes based on the provided [RouteSettings].
  ///
  /// This method is called when the app needs to navigate to a new route.
  /// It returns a [Route] based on the route name provided in [RouteSettings].
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(LoginScreen());

      case '/DailyNews':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        // Extracts the article entity from the route arguments and passes it to the ArticleDetailsView.
        return _materialRoute(
          ArticleDetailsView(article: settings.arguments as ArticleEntity),
        );

      default:
        // If the route name doesn't match any case, the default route is the LoginScreen.
        return _materialRoute(LoginScreen());
    }
  }

  /// Helper method to create a [MaterialPageRoute] for the given [view].
  ///
  /// This method simplifies the process of creating routes by returning a [MaterialPageRoute]
  /// with the specified [view] as its content.
  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
