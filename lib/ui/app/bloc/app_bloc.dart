import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:podcast_app/ui/detail/models/episodes_model.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppPageChangedTo>(_onPageChangedTo);
    on<AppPodcastSelected>(_onPodcastSelected);
    on<AppEpisodeSelected>(_onEpisodeSelected);
    on<AppEpisodePaused>(_onEpisodePaused);
  }

  void _onPageChangedTo(
    AppPageChangedTo event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      pageStatus: event.page,
    ));
  }

  void _onPodcastSelected(
    AppPodcastSelected event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      podcast: event.podcast,
    ));
  }

  void _onEpisodeSelected(
    AppEpisodeSelected event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      episodeStatus: EpisodeStatus.empty,
    ));
    emit(state.copyWith(
      episode: event.episode,
      episodeStatus: EpisodeStatus.playing,
    ));
  }

  void _onEpisodePaused(
    AppEpisodePaused event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      episodeStatus: event.isPaused
          ? EpisodeStatus.pause
          : EpisodeStatus.playing,
    ));
  }
}
