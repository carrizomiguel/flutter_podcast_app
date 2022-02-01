import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/explore/data/repositories/explore_repository.dart';
import 'package:podcast_app/ui/explore/presentation/bloc/explore_bloc.dart';
import 'package:podcast_app/ui/explore/presentation/components/best_podcasts_list.dart';
import 'package:podcast_app/ui/explore/presentation/components/card_header.dart';
import 'package:podcast_app/ui/shared/widgets/custom_app_bar/custom_app_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: ExplorePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(
        repository: context.read<ExploreRepositoryImpl>(),
      )..add(ExploreBestPodcastsCalled()),
      child: const ExploreContent(),
    );
  }
}

class ExploreContent extends StatelessWidget {
  const ExploreContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomAppBar(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: CardHeader(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          BestPodcastsList(),
        ],
      ),
    );
  }
}
