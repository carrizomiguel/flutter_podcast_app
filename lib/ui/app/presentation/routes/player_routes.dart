import 'package:flutter/material.dart';
import 'package:podcast_app/ui/app/app.dart';
import 'package:podcast_app/ui/player/player.dart';

List<Page> onGeneratePlayerAppPages(AppState state, List<Page> pages) {
  switch (state.routeStatus) {
    case AppRouteStatus.app:
      return [AppContent.page()];
    case AppRouteStatus.player:
      return [
        AppContent.page(),
        PlayerPage.page(),
      ];
  }
}
