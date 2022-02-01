import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:podcast_app/ui/explore/data/repositories/explore_repository.dart';
import 'package:podcast_app/ui/explore/models/best_podcasts_model.dart';
import 'package:podcast_app/ui/explore/models/genres_model.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({
    required this.repository,
  }) : super(const ExploreState()) {
    on<ExploreBestPodcastsCalled>(_onListGenresCalled);
  }

  final ExploreRepository repository;

  void _onListGenresCalled(
    ExploreBestPodcastsCalled event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      status: ExploreStatus.loading,
    ));
    final result = await repository.getGenresList();
    await result.when(
      ok: (list) async {
        emit(state.copyWith(
          selectedGenre: (list.toList()..shuffle()).first,
        ));
        final result = await repository.getBestPodcastsList(
          state.selectedGenre!.id,
        );
        result.when(
          ok: (bestPodcasts) => emit(state.copyWith(
            status: ExploreStatus.success,
            bestPodcasts: bestPodcasts,
          )),
          err: (_) => emit(state.copyWith(
            status: ExploreStatus.failed,
          )),
        );
      },
      err: (_) async => emit(state.copyWith(
        status: ExploreStatus.failed,
      )),
    );
  }
}