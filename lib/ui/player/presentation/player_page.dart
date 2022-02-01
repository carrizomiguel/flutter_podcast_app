import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: PlayerPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PlayerContent();
  }
}

class PlayerContent extends StatelessWidget {
  const PlayerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Hero(
            tag: state.podcast!.id,
            child: Image.network(
              state.podcast!.thumbnail,
            ),
          );
        },
      ),
    );
  }
}
