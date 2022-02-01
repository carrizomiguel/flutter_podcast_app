import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/shared/constants.dart';
import 'package:podcast_app/ui/shared/models/podcasts.dart';

class BestPodcastsElement extends StatelessWidget {
  const BestPodcastsElement({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PodcastModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            model.thumbnail,
            height: 80,
            width: 100,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(width: 10),
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
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Icon(
            Iconsax.play,
            size: 20,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
