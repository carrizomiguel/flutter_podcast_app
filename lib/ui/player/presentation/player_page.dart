// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';
import 'package:podcast_app/ui/shared/constants.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: PlayerPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    return PlayerContent(
      appBloc: appBloc,
    );
  }
}

class PlayerContent extends StatefulWidget {
  const PlayerContent({
    Key? key,
    required this.appBloc,
  }) : super(key: key);

  final AppBloc appBloc;

  @override
  State<PlayerContent> createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> {
  Duration duration = const Duration(seconds: 1);
  Duration position = const Duration(seconds: 0);
  Duration empty = const Duration(hours: -286, minutes: -53, seconds: -18);

  @override
  void initState() {
    super.initState();
    _getDuration();
    widget.appBloc.audioPlayer.onAudioPositionChanged.listen((event) {
      if (mounted) {
        setState(() {
          position = event;
        });
      }
    });
  }

  _getDuration() async {
    double rawDuration = await widget.appBloc.audioPlayer.getDuration() / 1000;
    Duration parsedDurtion = Duration(seconds: (rawDuration).round());
    final hasDuration = parsedDurtion.compareTo(empty) != 0 ? true : false;
    if (mounted && hasDuration) {
      setState(() {
        duration = parsedDurtion;
      });
    }
  }

  @override
  void dispose() {
    widget.appBloc.audioPlayer.onDurationChanged.drain();
    widget.appBloc.audioPlayer.onAudioPositionChanged.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            widget.appBloc.add(const AppRouteChangedTo(
              route: AppRouteStatus.app,
            ));
          },
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isPaused = state.episodeStatus == EpisodeStatus.pause;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'from-footer-player',
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      state.episode!.thumbnail,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  state.episode!.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Row(
                  children: [
                    Text(position.toString().split('.')[0]),
                    const Spacer(),
                    Text(duration.toString().split('.')[0]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    final parsed = Duration(seconds: value.round());
                    widget.appBloc.audioPlayer.seek(parsed);
                  },
                  activeColor: kPrimaryColor,
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    widget.appBloc.add(AppEpisodePaused(
                      isPaused: !isPaused,
                    ));
                  },
                  child: Icon(
                    !isPaused
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_fill_rounded,
                    color: kPrimaryColor,
                    size: 70,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
