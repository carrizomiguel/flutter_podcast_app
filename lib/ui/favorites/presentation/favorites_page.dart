import 'package:flutter/material.dart';
import 'package:podcast_app/ui/favorites/presentation/components/card_header.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({ Key? key }) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: FavoritesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const FavoritesContent();
  }
}

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CardHeader(),
          )
        ],
      ),
    );
  }
}