part of 'app_bloc.dart';

enum AppPageStatus {
  home,
  explore,
  favorites,
  // profile,
}

enum AppRouteStatus {
  app,
  player,
}

enum EpisodeStatus {
  playing,
  pause,
  empty,
}

class AppState extends Equatable {
  const AppState({
    this.pageStatus = AppPageStatus.home,
    this.podcast,
    this.routeStatus = AppRouteStatus.app,
    this.episode,
    this.episodeStatus = EpisodeStatus.empty,
  });

  final AppPageStatus pageStatus;
  final PodcastModel? podcast;
  final AppRouteStatus routeStatus;
  final EpisodesModel? episode;
  final EpisodeStatus episodeStatus;

  AppState copyWith({
    AppPageStatus? pageStatus,
    PodcastModel? podcast,
    AppRouteStatus? routeStatus,
    EpisodesModel? episode,
    EpisodeStatus? episodeStatus,
  }) {
    return AppState(
      pageStatus: pageStatus ?? this.pageStatus,
      podcast: podcast ?? this.podcast,
      routeStatus: routeStatus ?? this.routeStatus,
      episode: episode ?? this.episode,
      episodeStatus: episodeStatus ?? this.episodeStatus,
    );
  }

  @override
  List<Object?> get props => [
    pageStatus,
    podcast,
    routeStatus,
    episode,
    episodeStatus,
  ];
}
