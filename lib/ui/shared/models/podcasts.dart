import 'dart:convert';

List<PodcastModel> podcastsFromJson(String str) => List<PodcastModel>.from(
  json.decode(str).map((x) => PodcastModel.fromJson(x)),
);

String podcastsToJson(List<PodcastModel> data) => json.encode(
  List<dynamic>.from(data.map((x) => x.toJson())),
);

PodcastModel podcastFromJson(String str) => PodcastModel.fromJson(json.decode(str));

String podcastToJson(PodcastModel data) => json.encode(data.toJson());

class PodcastModel {
  PodcastModel({
    required this.id,
    required this.image,
    required this.title,
    required this.publisher,
    required this.thumbnail,
    this.listenScore,
    required this.listennotesUrl,
    this.listenScoreGlobalRank,
  });

  String id;
  String image;
  String title;
  String publisher;
  String thumbnail;
  String? listenScore;
  String listennotesUrl;
  String? listenScoreGlobalRank;

  factory PodcastModel.fromJson(Map<String, dynamic> json) => PodcastModel(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    publisher: json["publisher"],
    thumbnail: json["thumbnail"],
    listenScore: json["listen_score"].toString(),
    listennotesUrl: json["listennotes_url"],
    listenScoreGlobalRank: json["listen_score_global_rank"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "publisher": publisher,
    "thumbnail": thumbnail,
    "listen_score": listenScore,
    "listennotes_url": listennotesUrl,
    "listen_score_global_rank": listenScoreGlobalRank,
  };
}
