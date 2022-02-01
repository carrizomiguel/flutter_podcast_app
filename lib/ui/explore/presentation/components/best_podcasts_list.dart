import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/explore/presentation/bloc/explore_bloc.dart';
import 'package:podcast_app/ui/explore/presentation/components/best_podcasts_element.dart';
import 'package:podcast_app/ui/shared/constants.dart';

class BestPodcastsList extends StatelessWidget {
  const BestPodcastsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state.status == ExploreStatus.success) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trending Podcasts!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        state.selectedGenre!.name,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  state.bestPodcasts!.podcasts.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: BestPodcastsElement(
                      model: state.bestPodcasts!.podcasts[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ),
        );
      },
    );
  }
}
