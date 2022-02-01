import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/storage/cached_constants.dart';
import 'package:podcast_app/core/storage/storage.dart';
import 'package:podcast_app/ui/explore/models/best_podcasts_model.dart';
import 'package:podcast_app/ui/explore/models/genres_model.dart';

abstract class ExploreLocalDataSource {
  Future<void> cacheLastGenresList(List<GenresModel> list);
  Future<List<GenresModel>> getLastGenresList();
  Future<void> cacheLastBestPodcasts(BestPodcastsModel model);
  Future<BestPodcastsModel> getLastBestPodcasts(int idGenre);
}

class ExploreLocalDataSourceImpl implements ExploreLocalDataSource {
  ExploreLocalDataSourceImpl({required this.storage});

  final Storage storage;

  @override
  Future<void> cacheLastBestPodcasts(BestPodcastsModel model) async {
    return await storage.write(
      Cached.bestPodcasts,
      bestPodcastsToJson(model),
    );
  }

  @override
  Future<void> cacheLastGenresList(List<GenresModel> list) async {
    return await storage.write(
      Cached.genres,
      genresToJson(list),
    );
  }

  @override
  Future<BestPodcastsModel> getLastBestPodcasts(int idGenre) async {
    try {
      final value = await storage.read(Cached.bestPodcasts);
      final bestPodcasts = bestPodcastsFromJson(value);
      if (bestPodcasts.id != idGenre) throw EmptyException();
      return Future.value(bestPodcasts);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<GenresModel>> getLastGenresList() async {
    try {
      final value = await storage.read(Cached.genres);
      return Future.value(genresFromJson(value));
    } catch (_) {
      throw CacheException();
    }
  }
}
