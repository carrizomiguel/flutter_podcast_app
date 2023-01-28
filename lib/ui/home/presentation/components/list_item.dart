import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/app/app.dart';
import 'package:podcast_app/ui/detail/detail.dart';
import 'package:podcast_app/ui/shared/constants.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PodcastModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: model.thumbnail,
              child: Image.network(
                model.thumbnail,
                height: 100,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  model.publisher,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          OpenContainer(
            closedElevation: 0,
            middleColor: Colors.white,
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (_, action) {
              final appBloc = context.read<AppBloc>();
              appBloc.add(AppPodcastSelected(
                podcast: model,
              ));
              return DetailPage(
                idPodcast: model.id,
              );
            },
            closedBuilder: (context, action) => Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.play,
                size: 20,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
