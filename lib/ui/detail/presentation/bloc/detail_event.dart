part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailPodcastDetailCalled extends DetailEvent {
  const DetailPodcastDetailCalled({required this.idPodcast});

  final String idPodcast;
}
