import 'package:oxidized/oxidized.dart';
import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/error/failures.dart';
import 'package:podcast_app/core/network/network_info.dart';
import 'package:podcast_app/ui/explore/data/datasources/explore_local_data_source.dart';
import 'package:podcast_app/ui/explore/data/datasources/explore_remote_data_source.dart';
import 'package:podcast_app/ui/explore/models/best_podcasts_model.dart';
import 'package:podcast_app/ui/explore/models/genres_model.dart';

abstract class ExploreRepository {
  Future<Result<List<GenresModel>, Failure>> getGenresList();
  Future<Result<BestPodcastsModel, Failure>> getBestPodcastsList(
    int idGenre,
  );
}

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ExploreLocalDataSource localDataSource;
  final ExploreRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Result<BestPodcastsModel, Failure>> getBestPodcastsList(
    int idGenre,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final local = await localDataSource.getLastBestPodcasts(idGenre);
        return Result.ok(local);
      } on EmptyException {
        return Result.err(EmptyFailure());
      } on CacheException {
        try {
          final remote = await remoteDataSource.getBestPodcastsByGenre(idGenre);
          await localDataSource.cacheLastBestPodcasts(remote);
          return Result.ok(remote);
        } on WrongApiKeyException {
          return Result.err(WrongApiKeyFailure());
        } on FreePlanExceededException {
          return Result.err(FreePlanExceededFailure());
        } on ServerException {
          return Result.err(ServerFailure());
        }
      }
    } else {
      try {
        final local = await localDataSource.getLastBestPodcasts(idGenre);
        return Result.ok(local);
      } on EmptyException {
        return Result.err(EmptyFailure());
      } on CacheException {
        return Result.err(CacheFailure());
      }
    }
  }

  @override
  Future<Result<List<GenresModel>, Failure>> getGenresList() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getGenres();
        await localDataSource.cacheLastGenresList(remote);
        return Result.ok(remote);
      } on WrongApiKeyException {
        return Result.err(WrongApiKeyFailure());
      } on FreePlanExceededException {
        return Result.err(FreePlanExceededFailure());
      } on ServerException {
        return Result.err(ServerFailure());
      }
    } else {
      try {
        final local = await localDataSource.getLastGenresList();
        return Result.ok(local);
      } on EmptyException {
        return Result.err(EmptyFailure());
      } on CacheException {
        return Result.err(CacheFailure());
      }
    }
  }
}
