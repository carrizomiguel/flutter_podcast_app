import 'dart:convert';

import 'package:podcast_app/ui/shared/models/podcasts.dart';

List<SelectedPodcastsModel> selectedPodcastsFromJson(
  String str,
) => List<SelectedPodcastsModel>.from(
  json.decode(str).map((x) => SelectedPodcastsModel.fromJson(x)),
);

String selectedPodcastsToJson(
  List<SelectedPodcastsModel> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedPodcastsModel {
  SelectedPodcastsModel({
    required this.id,
    required this.title,
    required this.total,
    required this.podcasts,
    required this.sourceUrl,
    required this.description,
    required this.pubDateMs,
    required this.sourceDomain,
    required this.listennotesUrl,
  });

  String id;
  String title;
  int total;
  List<PodcastModel> podcasts;
  String sourceUrl;
  String description;
  int pubDateMs;
  String sourceDomain;
  String listennotesUrl;

  factory SelectedPodcastsModel.fromJson(
    Map<String, dynamic> json,
  ) => SelectedPodcastsModel(
    id: json["id"],
    title: json["title"],
    total: json["total"],
    podcasts: List<PodcastModel>.from(
      json["podcasts"].map((x) => PodcastModel.fromJson(x)),
    ),
    sourceUrl: json["source_url"],
    description: json["description"],
    pubDateMs: json["pub_date_ms"],
    sourceDomain: json["source_domain"],
    listennotesUrl: json["listennotes_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "total": total,
    "podcasts": List<dynamic>.from(podcasts.map((x) => x.toJson())),
    "source_url": sourceUrl,
    "description": description,
    "pub_date_ms": pubDateMs,
    "source_domain": sourceDomain,
    "listennotes_url": listennotesUrl,
  };
}
