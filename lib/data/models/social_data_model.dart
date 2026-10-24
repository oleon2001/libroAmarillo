import '../../../domain/entities/social_data.dart';

class SocialDataModel extends SocialData {
  const SocialDataModel({
    required super.instagramUrl,
    required super.followersCount,
    required super.latestPostsUrls,
    required super.lastScrapedAt,
  });

  factory SocialDataModel.fromJson(Map<String, dynamic> json) {
    return SocialDataModel(
      instagramUrl: json['instagramUrl'] ?? '',
      followersCount: json['followersCount'] ?? 0,
      latestPostsUrls: List<String>.from(json['latestPostsUrls'] ?? []),
      lastScrapedAt: json['lastScrapedAt'] != null 
          ? DateTime.parse(json['lastScrapedAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagramUrl': instagramUrl,
      'followersCount': followersCount,
      'latestPostsUrls': latestPostsUrls,
      'lastScrapedAt': lastScrapedAt.toIso8601String(),
    };
  }
}
