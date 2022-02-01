part of 'detail_bloc.dart';

enum DetailStatus {
  loading,
  success,
  failed,
  empty,
}

class DetailState extends Equatable {
  const DetailState({
    this.status = DetailStatus.loading,
    this.podcastDetail,
  });

  final DetailStatus status;
  final PodcastDetailModel? podcastDetail;

  DetailState copyWith({
    DetailStatus? status,
    PodcastDetailModel? podcastDetail,
  }) {
    return DetailState(
      status: status ?? this.status,
      podcastDetail: podcastDetail ?? this.podcastDetail,
    );
  }
  
  @override
  List<Object?> get props => [status, podcastDetail];
}
