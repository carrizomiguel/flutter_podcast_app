import 'dart:convert';

import 'package:podcast_app/ui/detail/models/episodes_model.dart';

PodcastDetailModel podcastDetailFromJson(
  String str,
) =>
    PodcastDetailModel.fromJson(json.decode(str));

String podcastDetailToJson(
  PodcastDetailModel data,
) => json.encode(data.toJson());

class PodcastDetailModel {
  PodcastDetailModel({
    required this.id,
    required this.rss,
    required this.type,
    required this.email,
    required this.image,
    required this.title,
    required this.country,
    required this.website,
    required this.episodes,
    required this.language,
    required this.genreIds,
    required this.itunesId,
    required this.publisher,
    required this.thumbnail,
    required this.isClaimed,
    required this.description,
    required this.totalEpisodes,
    required this.listennotesUrl,
    required this.explicitContent,
    required this.latestPubDateMs,
    required this.earliestPubDateMs,
    required this.nextEpisodePubDate,
    required this.listenScoreGlobalRank,
  });

  String id;
  String rss;
  String type;
  String email;
  String image;
  String title;
  String country;
  String website;
  List<EpisodesModel> episodes;
  String language;
  List<int> genreIds;
  int itunesId;
  String publisher;
  String thumbnail;
  bool isClaimed;
  String description;
  int totalEpisodes;
  String listennotesUrl;
  bool explicitContent;
  int latestPubDateMs;
  int earliestPubDateMs;
  int nextEpisodePubDate;
  String listenScoreGlobalRank;

  factory PodcastDetailModel.fromJson(Map<String, dynamic> json) => PodcastDetailModel(
    id: json["id"],
    rss: json["rss"],
    type: json["type"],
    email: json["email"],
    image: json["image"],
    title: json["title"],
    country: json["country"],
    website: json["website"],
    episodes: List<EpisodesModel>.from(
      json["episodes"].map((x) => EpisodesModel.fromJson(x)),
    ),
    language: json["language"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    itunesId: json["itunes_id"],
    publisher: json["publisher"],
    thumbnail: json["thumbnail"],
    isClaimed: json["is_claimed"],
    description: json["description"],
    totalEpisodes: json["total_episodes"],
    listennotesUrl: json["listennotes_url"],
    explicitContent: json["explicit_content"],
    latestPubDateMs: json["latest_pub_date_ms"],
    earliestPubDateMs: json["earliest_pub_date_ms"],
    nextEpisodePubDate: json["next_episode_pub_date"],
    listenScoreGlobalRank: json["listen_score_global_rank"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rss": rss,
    "type": type,
    "email": email,
    "image": image,
    "title": title,
    "country": country,
    "website": website,
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    "language": language,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "itunes_id": itunesId,
    "publisher": publisher,
    "thumbnail": thumbnail,
    "is_claimed": isClaimed,
    "description": description,
    "total_episodes": totalEpisodes,
    "listennotes_url": listennotesUrl,
    "explicit_content": explicitContent,
    "latest_pub_date_ms": latestPubDateMs,
    "earliest_pub_date_ms": earliestPubDateMs,
    "next_episode_pub_date": nextEpisodePubDate,
    "listen_score_global_rank": listenScoreGlobalRank,
  };
}
