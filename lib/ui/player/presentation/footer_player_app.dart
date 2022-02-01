// ignore_for_file: avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';
import 'package:podcast_app/ui/detail/models/episodes_model.dart';
import 'package:podcast_app/ui/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FooterPlayerApp extends StatefulWidget {
  const FooterPlayerApp({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final EpisodesModel episode;

  @override
  State<FooterPlayerApp> createState() => _FooterPlayerAppState();
}

class _FooterPlayerAppState extends State<FooterPlayerApp> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    initPlayer();
    print('init state ===> IN WIDGET');
  }

  void initPlayer() async {
    audioPlayer = AudioPlayer();
    await audioPlayer.stop();
    await audioPlayer.play(widget.episode.audio);
    print('init player ===> IN FUNCTION');
  }

  void pausePlayer(bool isPaused) async {
    if (isPaused) {
      await audioPlayer.pause();
      return;
    }
    await audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final appBloc = context.read<AppBloc>();
    final status = appBloc.state.episodeStatus;

    bool isPaused() {
      final condition = status == EpisodeStatus.pause;
      pausePlayer(condition);
      return condition;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      width: screenWidth,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        width: double.infinity,
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.episode.image,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.episode.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        color: kSecondaryColor,
                        backgroundColor: Colors.grey.shade200,
                        value: widget.episode.audioLengthSec.toDouble(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    appBloc.add(AppEpisodePaused(
                      isPaused: !isPaused(),
                    ));
                  },
                  icon: Icon(
                    isPaused()
                        ? Iconsax.play
                        : Iconsax.pause,
                  ),
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
