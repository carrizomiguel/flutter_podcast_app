import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';
import 'package:podcast_app/ui/app/presentation/routes/player_routes.dart';
import 'package:podcast_app/ui/app/presentation/routes/routes.dart';
import 'package:podcast_app/ui/player/presentation/footer_player_app.dart';
import 'package:podcast_app/ui/shared/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(),
      child: const AppRoutes(),
    );
  }
}

class AppRoutes extends StatelessWidget {
  const AppRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podcast App',
      debugShowCheckedModeBanner: false,
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state),
        observers: [HeroController()],
        onGeneratePages: onGeneratePlayerAppPages,
      ),
    );
  }
}

class AppContent extends StatelessWidget {
  const AppContent({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: AppContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FlowBuilder(
            state: context.select((AppBloc bloc) => bloc.state),
            onGeneratePages: onGenerateAppPages,
          ),
          Positioned(
            bottom: 0,
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state.episodeStatus != EpisodeStatus.empty) {
                  return FooterPlayerApp(
                    episode: state.episode!,
                    appBloc: context.read<AppBloc>(),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
