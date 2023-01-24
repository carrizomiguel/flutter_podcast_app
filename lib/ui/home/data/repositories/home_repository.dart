import 'package:oxidized/oxidized.dart';
import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/error/failures.dart';
import 'package:podcast_app/core/network/network_info.dart';
import 'package:podcast_app/ui/home/data/datasources/home_local_data_source.dart';
import 'package:podcast_app/ui/home/data/datasources/home_remote_data_source.dart';
import 'package:podcast_app/ui/home/models/selected_postcasts_model.dart';

abstract class HomeRepository {
  Future<Result<List<SelectedPodcastsModel>, Failure>> getSelectedPodcasts();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Result<List<SelectedPodcastsModel>, Failure>>
      getSelectedPodcasts() async {
    if (await networkInfo.isConnected) {
      try {
        final local = await localDataSource.getLastSelectedPodcastsList();
        return Result.ok(local);
      } on CacheException {
        try {
          final remote = await remoteDataSource.getSelectedPodcasts();
          await localDataSource.cacheLastSelectedPodcastsList(remote);
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
        final local = await localDataSource.getLastSelectedPodcastsList();
        return Result.ok(local);
      } on CacheException {
        return Result.err(CacheFailure());
      }
    }
  }
}
