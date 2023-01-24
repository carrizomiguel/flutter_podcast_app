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
        selectedPodcasts = list;
        emit(HomeSuccess());
      },
      err: (failure) {
        // ignore: avoid_print
        print('home failure ===> $failure');
        emit(HomeFailed());
      },
    );
  }
}
