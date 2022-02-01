part of 'explore_bloc.dart';

enum ExploreStatus {
  loading,
  success,
  failed,
  empty,
}

class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.loading,
    this.selectedGenre,
    this.bestPodcasts,
  });

  final ExploreStatus status;
  final GenresModel? selectedGenre;
  final BestPodcastsModel? bestPodcasts;
  
  ExploreState copyWith({
    ExploreStatus? status,
    GenresModel? selectedGenre,
    BestPodcastsModel? bestPodcasts,
  }) {
    return ExploreState(
      status: status ?? this.status,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      bestPodcasts: bestPodcasts ?? this.bestPodcasts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedGenre,
    bestPodcasts,
  ];
}
