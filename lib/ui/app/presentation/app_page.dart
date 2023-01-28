import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/app/app.dart';
import 'package:podcast_app/ui/explore/explore.dart';
import 'package:podcast_app/ui/favorites/favorites.dart';
import 'package:podcast_app/ui/home/home.dart';
import 'package:podcast_app/ui/player/player.dart';
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
    final appBloc = context.read<AppBloc>();

    Widget switchScreens(AppPageStatus status) {
      switch (status) {
        case AppPageStatus.home:
          return const HomePage();
        case AppPageStatus.explore:
          return const ExplorePage();
        case AppPageStatus.favorites:
          return const FavoritesPage();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          switchScreens(appBloc.state.pageStatus),
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
