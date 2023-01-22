import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:podcast_app/ui/shared/constants.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: kSecondaryColor,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wake Your\nMind Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Creative Studio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.headphone,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -15,
          right: 5,
          child: Image.asset(
            'assets/images/music-guy.png',
            height: 230,
          ),
        )
      ],
    );
  }
}
