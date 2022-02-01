import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/storage/cached_constants.dart';
import 'package:podcast_app/core/storage/storage.dart';
import 'package:podcast_app/ui/home/models/selected_postcasts_model.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheLastSelectedPodcastsList(
    List<SelectedPodcastsModel> list,
  );
  Future<List<SelectedPodcastsModel>> getLastSelectedPodcastsList();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required this.storage});

  final Storage storage;

  @override
  Future<void> cacheLastSelectedPodcastsList(
    List<SelectedPodcastsModel> list,
  ) async {
    return await storage.write(
      Cached.selectedPodcasts,
      selectedPodcastsToJson(list),
    );
  }

  @override
  Future<List<SelectedPodcastsModel>> getLastSelectedPodcastsList() async {
    try {
      final value = await storage.read(Cached.selectedPodcasts);
      return Future.value(selectedPodcastsFromJson(value));
    } catch (_) {
      throw CacheException();
    }
  }
}
