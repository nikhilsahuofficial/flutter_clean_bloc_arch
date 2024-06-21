import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc_arch/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';

import '../../../domain/entities/article.dart';
import '../../bloc/article/remote_article_state.dart';
import '../../bloc/login/auth_bloc.dart';
import '../../bloc/login/auth_event.dart';
import '../../widgets/article_tile.dart';

/// Widget for displaying daily news articles.
class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  /// Builds the app bar for the DailyNews screen.
  _buildAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Daily News',

        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Trigger logout functionality via AuthBloc
            context.read<AuthBloc>().add(AuthLogoutRequested());
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.logout, color: Colors.black),
          ),
        ),
      ],
    );
  }

  /// Builds the body of the DailyNews screen.
  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  /// Navigates to the ArticleDetails screen when an article tile is pressed.
  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
