import 'package:flutter/material.dart';
import 'package:podcast_app/ui/home/models/selected_postcasts_model.dart';
import 'package:podcast_app/ui/home/presentation/components/card_item.dart';
import 'package:podcast_app/ui/home/presentation/components/list_item.dart';
import 'package:podcast_app/ui/shared/widgets/custom_app_bar/custom_app_bar.dart';

class SelectedPodcasts extends StatelessWidget {
  const SelectedPodcasts({
    Key? key,
    required this.selectedList,
  }) : super(key: key);

  final List<SelectedPodcastsModel> selectedList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomAppBar(),
          ),
          for (var selected in selectedList) ...[
            if (selected.podcasts.length >= 5) ...[
              SectionTitle(selected: selected),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selected.podcasts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 20 : 0,
                            right: index == (selected.podcasts.length - 1)
                                ? 20
                                : 0),
                        child: CardItem(
                          model: selected.podcasts[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ] else ...[
              SectionTitle(selected: selected),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    selected.podcasts.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListItem(
                        model: selected.podcasts[index],
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ]
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final SelectedPodcastsModel selected;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Text(selected.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )),
      ),
    );
  }
}
