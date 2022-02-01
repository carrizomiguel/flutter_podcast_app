import 'dart:convert';

List<EpisodesModel> episodesFromJson(
  String str,
) => List<EpisodesModel>.from(
  json.decode(str).map((x) => EpisodesModel.fromJson(x)),
);

String episodesToJson(
  List<EpisodesModel> data,
) => json.encode(
  List<dynamic>.from(data.map((x) => x.toJson())),
);

class EpisodesModel {
  EpisodesModel({
    required this.id,
    required this.link,
    required this.audio,
    required this.image,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.pubDateMs,
    required this.guidFromRss,
    required this.listennotesUrl,
    required this.audioLengthSec,
    required this.explicitContent,
    required this.maybeAudioInvalid,
    required this.listennotesEditUrl,
  });

  String id;
  String link;
  String audio;
  String image;
  String title;
  String thumbnail;
  String description;
  int pubDateMs;
  String guidFromRss;
  String listennotesUrl;
  int audioLengthSec;
  bool explicitContent;
  bool maybeAudioInvalid;
  String listennotesEditUrl;

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
    id: json["id"],
    link: json["link"],
    audio: json["audio"],
    image: json["image"],
    title: json["title"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    pubDateMs: json["pub_date_ms"],
    guidFromRss: json["guid_from_rss"],
    listennotesUrl: json["listennotes_url"],
    audioLengthSec: json["audio_length_sec"],
    explicitContent: json["explicit_content"],
    maybeAudioInvalid: json["maybe_audio_invalid"],
    listennotesEditUrl: json["listennotes_edit_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "audio": audio,
    "image": image,
    "title": title,
    "thumbnail": thumbnail,
    "description": description,
    "pub_date_ms": pubDateMs,
    "guid_from_rss": guidFromRss,
    "listennotes_url": listennotesUrl,
    "audio_length_sec": audioLengthSec,
    "explicit_content": explicitContent,
    "maybe_audio_invalid": maybeAudioInvalid,
    "listennotes_edit_url": listennotesEditUrl,
  };
}
