import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/app/bloc/app_bloc.dart';
import 'package:podcast_app/ui/detail/detail.dart';
import 'package:podcast_app/ui/shared/constants.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PodcastModel model;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    return Hero(
      tag: model.id,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: 170,
          child: Column(
            children: [
              Image.network(
                model.thumbnail,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: OpenContainer(
                        closedElevation: 0,
                        middleColor: Colors.white,
                        transitionType: ContainerTransitionType.fadeThrough,
                        openBuilder: (_, action) {
                          appBloc.add(AppPodcastSelected(
                            podcast: model,
                          ));
                          return DetailPage(
                            idPodcast: model.id,
                          );
                        },
                        closedBuilder: (context, action) => Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.play,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            model.publisher,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
