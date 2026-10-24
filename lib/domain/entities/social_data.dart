class SocialData {
  final String instagramUrl;
  final int followersCount;
  final List<String> latestPostsUrls;
  final DateTime lastScrapedAt;

  const SocialData({
    required this.instagramUrl,
    required this.followersCount,
    required this.latestPostsUrls,
    required this.lastScrapedAt,
  });
}
