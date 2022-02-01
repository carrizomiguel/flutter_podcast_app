import 'dart:convert';

import 'package:podcast_app/ui/shared/models/podcasts.dart';

BestPodcastsModel bestPodcastsFromJson(
  String str,
) =>
    BestPodcastsModel.fromJson(
      json.decode(str),
    );

String bestPodcastsToJson(
  BestPodcastsModel data,
) => json.encode(data.toJson());

class BestPodcastsModel {
  BestPodcastsModel({
    required this.id,
    required this.name,
    required this.total,
    required this.hasNext,
    required this.podcasts,
    required this.parentId,
    required this.pageNumber,
    required this.hasPrevious,
    required this.listennotesUrl,
    required this.nextPageNumber,
    required this.previousPageNumber,
  });

  int id;
  String name;
  int total;
  bool hasNext;
  List<PodcastModel> podcasts;
  int parentId;
  int pageNumber;
  bool hasPrevious;
  String listennotesUrl;
  int nextPageNumber;
  int previousPageNumber;

  factory BestPodcastsModel.fromJson(
    Map<String, dynamic> json,
  ) => BestPodcastsModel(
    id: json["id"],
    name: json["name"],
    total: json["total"],
    hasNext: json["has_next"],
    podcasts: List<PodcastModel>.from(
      json["podcasts"].map((x) => PodcastModel.fromJson(x)),
    ),
    parentId: json["parent_id"],
    pageNumber: json["page_number"],
    hasPrevious: json["has_previous"],
    listennotesUrl: json["listennotes_url"],
    nextPageNumber: json["next_page_number"],
    previousPageNumber: json["previous_page_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total": total,
    "has_next": hasNext,
    "podcasts": List<dynamic>.from(podcasts.map((x) => x.toJson())),
    "parent_id": parentId,
    "page_number": pageNumber,
    "has_previous": hasPrevious,
    "listennotes_url": listennotesUrl,
    "next_page_number": nextPageNumber,
    "previous_page_number": previousPageNumber,
  };
}
