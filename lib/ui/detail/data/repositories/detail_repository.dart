import 'package:oxidized/oxidized.dart';
import 'package:podcast_app/core/error/exceptions.dart';
import 'package:podcast_app/core/error/failures.dart';
import 'package:podcast_app/core/network/network_info.dart';
import 'package:podcast_app/ui/detail/data/datasources/detail_local_data_source.dart';
import 'package:podcast_app/ui/detail/data/datasources/detail_remote_data_source.dart';
import 'package:podcast_app/ui/detail/models/podcast_detail.dart';

abstract class DetailRepository {
  Future<Result<PodcastDetailModel, Failure>> getPodcastDetail(
    String idPodcast,
  );
}

class DetailRepositoryImpl implements DetailRepository {
  DetailRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final DetailLocalDataSource localDataSource;
  final DetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Result<PodcastDetailModel, Failure>> getPodcastDetail(
    String idPodcast,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getPodcastDetail(idPodcast);
        await localDataSource.cacheLastPodcastDetail(remote);
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
        final local = await localDataSource.getLastPodcastDetail(idPodcast);
        return Result.ok(local);
      } on EmptyException {
        return Result.err(EmptyFailure());
      } on CacheException {
        return Result.err(CacheFailure());
      }
    }
  }
}
