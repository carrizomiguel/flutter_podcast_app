import 'package:flutter/material.dart';
import 'package:podcast_app/ui/app/app.dart';
import 'package:podcast_app/ui/explore/explore.dart';
import 'package:podcast_app/ui/favorites/favorites.dart';
import 'package:podcast_app/ui/home/home.dart';

List<Page> onGenerateAppPages(AppState state, List<Page> pages) {
  switch (state.pageStatus) {
    case AppPageStatus.home:
      return [
        HomePage.page(),
      ];
    case AppPageStatus.explore:
      return [
        ExplorePage.page(),
      ];
    case AppPageStatus.favorites:
      return [
        FavoritesPage.page(),
      ];
  }
}
