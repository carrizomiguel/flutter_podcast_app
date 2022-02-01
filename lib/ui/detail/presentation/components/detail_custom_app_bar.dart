import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailCustomAppBar extends StatelessWidget {
  const DetailCustomAppBar({
    Key? key,
    required this.publisher,
    required this.thumbnail,
  }) : super(key: key);

  final String publisher;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Iconsax.arrow_left_2,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            publisher,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const Spacer(),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size(screenWidth, 230),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: thumbnail,
                  child: Image.network(
                    thumbnail,
                    height: 200,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
