class Api {
  static const keyLabel = 'X-ListenAPI-Key';
  static const keyValue = '72745cb4d7624751a8d1c5946a77e610';

  static const authority = 'listen-api.listennotes.com';
  static const path = '/api/v2';
  static const curatedPodcastsPath = '$path/curated_podcasts';
  static const genresPath = '$path/genres';
  static const bestPodcastsPath = '$path/best_podcasts';
  static podcastByIdPath(String id) => '$path/podcasts/$id';
}
