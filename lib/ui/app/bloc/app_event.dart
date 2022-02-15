part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppPageChangedTo extends AppEvent {
  const AppPageChangedTo({required this.page});

  final AppPageStatus page;
}

class AppRouteChangedTo extends AppEvent {
  const AppRouteChangedTo({required this.route});

  final AppRouteStatus route;
}

class AppPodcastSelected extends AppEvent {
  const AppPodcastSelected({required this.podcast});

  final PodcastModel podcast;
}

class AppEpisodeSelected extends AppEvent {
  const AppEpisodeSelected({required this.episode});
  
  final EpisodesModel episode;
}

class AppEpisodePaused extends AppEvent {
  const AppEpisodePaused({required this.isPaused});

  final bool isPaused;
}
