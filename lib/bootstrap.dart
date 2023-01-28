import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/core/network/network_info.dart';
import 'package:podcast_app/core/storage/storage.dart';
import 'package:podcast_app/ui/detail/detail.dart';
import 'package:podcast_app/ui/explore/explore.dart';
import 'package:podcast_app/ui/home/home.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Storage initialization
      final storage = Storage();
      storage.init();

      // Network Info
      final networkInfo = NetworkInfoImpl();

      // Home
      final homeLocalDataSource = HomeLocalDataSourceImpl(
        storage: storage,
      );
      final homeRemoteDataSource = HomeRemoteDataSourceImpl();

      // Explore
      final exploreLocalDataSource = ExploreLocalDataSourceImpl(
        storage: storage,
      );
      final exploreRemoteDataSource = ExploreRemoteDataSourceImpl();

      // Detail
      final detailLocalDataSource = DetailLocalDataSourceImpl(
        storage: storage,
      );
      final detailRemoteDataSource = DetailRemoteDataSourceImpl();

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<HomeRepositoryImpl>(
              create: (_) => HomeRepositoryImpl(
                localDataSource: homeLocalDataSource,
                remoteDataSource: homeRemoteDataSource,
                networkInfo: networkInfo,
              ),
            ),
            RepositoryProvider<ExploreRepositoryImpl>(
              create: (_) => ExploreRepositoryImpl(
                localDataSource: exploreLocalDataSource,
                remoteDataSource: exploreRemoteDataSource,
                networkInfo: networkInfo,
              ),
            ),
            RepositoryProvider<DetailRepositoryImpl>(
              create: (_) => DetailRepositoryImpl(
                localDataSource: detailLocalDataSource,
                remoteDataSource: detailRemoteDataSource,
                networkInfo: networkInfo,
              ),
            ),
          ],
          child: await builder(),
        ),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
