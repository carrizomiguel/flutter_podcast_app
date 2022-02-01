import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:podcast_app/ui/detail/data/repositories/detail_repository.dart';
import 'package:podcast_app/ui/detail/models/podcast_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required this.repository,
  }) : super(const DetailState()) {
    on<DetailPodcastDetailCalled>(_onPodcastDetailCalled);
  }

  final DetailRepository repository;

  void _onPodcastDetailCalled(
    DetailPodcastDetailCalled event,
    Emitter emit,
  ) async {
    emit(state.copyWith(
      status: DetailStatus.loading,
    ));
    final result = await repository.getPodcastDetail(
      event.idPodcast,
    );
    result.when(
      ok: (detail) => emit(state.copyWith(
        status: DetailStatus.success,
        podcastDetail: detail,
      )),
      err: (_) => emit(state.copyWith(
        status: DetailStatus.failed,
      )),
    );
  }
}
