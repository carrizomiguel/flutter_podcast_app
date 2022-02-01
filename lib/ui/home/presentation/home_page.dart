import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/home/data/repositories/home_repository.dart';
import 'package:podcast_app/ui/home/presentation/bloc/home_bloc.dart';
import 'package:podcast_app/ui/home/presentation/components/selected_podcasts.dart';
import 'package:podcast_app/ui/shared/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        repository: context.read<HomeRepositoryImpl>(),
      )..add(HomeListSelectedPodcastsCalled()),
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final list = context.read<HomeBloc>().selectedPodcasts;
        if (state is HomeSuccess) {
          return SelectedPodcasts(
            selectedList: list,
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      },
    );
  }
}
