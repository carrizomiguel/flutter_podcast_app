import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/detail/data/repositories/detail_repository.dart';
import 'package:podcast_app/ui/detail/presentation/bloc/detail_bloc.dart';
import 'package:podcast_app/ui/detail/presentation/components/detail_actions.dart';
import 'package:podcast_app/ui/detail/presentation/components/detail_custom_app_bar.dart';
import 'package:podcast_app/ui/detail/presentation/components/episodes_list.dart';
import 'package:podcast_app/ui/shared/constants.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.idPodcast,
  }) : super(key: key);

  final String idPodcast;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailBloc(
        repository: context.read<DetailRepositoryImpl>(),
      )..add(DetailPodcastDetailCalled(idPodcast: idPodcast)),
      child: const DetailContent(),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state.status == DetailStatus.success) {
            final podcast = state.podcastDetail!;
            return CustomScrollView(
              slivers: [
                DetailCustomAppBar(
                  publisher: podcast.publisher,
                  thumbnail: podcast.thumbnail,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                DetailActions(
                  title: podcast.title,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                EpisodesList(
                  episodes: podcast.episodes.reversed.toList(),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
