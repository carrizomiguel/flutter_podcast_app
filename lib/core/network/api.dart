class Api {
  static const keyLabel = 'X-ListenAPI-Key';
  static const keyValue = 'YOUR_API_KEY_HERE';

  static const authority = 'listen-api.listennotes.com';
  static const path = '/api/v2';
  static const curatedPodcastsPath = '$path/curated_podcasts';
  static const genresPath = '$path/genres';
  static const bestPodcastsPath = '$path/best_podcasts';
  static podcastByIdPath(String id) => '$path/podcasts/$id';
}