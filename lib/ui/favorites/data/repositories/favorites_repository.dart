import 'package:oxidized/oxidized.dart';
import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/error/failures.dart';
import 'package:podcast_app/ui/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';

abstract class FavoritesRepository {
  Future<Result<List<PodcastModel>, Failure>> getFavorites();
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({
    required this.localDataSource,
  });

  final FavoritesLocalDataSource localDataSource;

  @override
  Future<Result<List<PodcastModel>, Failure>> getFavorites() async {
    try {
      final local = await localDataSource.getLastFavorites();
      return Result.ok(local);
    } on EmptyException {
      return Result.err(EmptyFailure());
    } on CacheException {
      return Result.err(CacheFailure());
    }
  }
}
