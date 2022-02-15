import 'package:flutter/material.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';
import 'package:podcast_app/ui/detail/models/episodes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesList extends StatelessWidget {
  const EpisodesList({
    Key? key,
    required this.episodes,
  }) : super(key: key);

  final List<EpisodesModel> episodes;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ...List.generate(
            episodes.length,
            (index) => EpisodesElement(
              episode: episodes[index],
            ),
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state.episodeStatus != EpisodeStatus.empty) {
                return const SizedBox(height: 100);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class EpisodesElement extends StatelessWidget {
  const EpisodesElement({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final EpisodesModel episode;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds).inMinutes)} min';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AppBloc>().add(AppEpisodeSelected(
              episode: episode,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                episode.image,
                height: 70,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    formatTime(episode.audioLengthSec),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Visibility(
                    visible: episode.explicitContent,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        'Explicit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
