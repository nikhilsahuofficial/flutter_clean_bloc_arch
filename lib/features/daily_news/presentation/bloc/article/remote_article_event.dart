/// Abstract base class for events related to remote articles.
abstract class RemoteArticlesEvent {
  const RemoteArticlesEvent();
}

/// Event class representing a request to fetch articles.
class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}
