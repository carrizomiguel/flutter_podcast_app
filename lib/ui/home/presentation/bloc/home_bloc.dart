import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:podcast_app/ui/home/data/repositories/home_repository.dart';
import 'package:podcast_app/ui/home/models/selected_postcasts_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.repository,
  }) : super(HomeLoading()) {
    on<HomeListSelectedPodcastsCalled>(_onListSelectedPodcastsCalled);
  }

  final HomeRepository repository;

  List<SelectedPodcastsModel> selectedPodcasts = [];

  void _onListSelectedPodcastsCalled(
    HomeListSelectedPodcastsCalled event,
    Emitter emit,
  ) async {
    emit(HomeLoading());
    final result = await repository.getSelectedPodcasts();
    result.when(
      ok: (list) {
        for (var selected in list) {
          selected.podcasts.removeWhere(
            (e) => e.id == '4147be1001cc4254bc2d660ae4cad6c4' ||
                e.id == 'd620156577fe4408972a29aa2675e628',
          );
        }
        selectedPodcasts = list;
        emit(HomeSuccess());
      },
      err: (_) => emit(HomeFailed()),
    );
  }
}
