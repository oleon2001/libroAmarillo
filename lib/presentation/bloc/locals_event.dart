abstract class LocalsEvent {
  const LocalsEvent();
}

class FetchLocalsEvent extends LocalsEvent {
  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;
  final String category;

  const FetchLocalsEvent({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
    required this.category,
  });
}

class SocialDataUpdatedEvent extends LocalsEvent {
  final dynamic updatedLocal; // Use LocalEntity type in bloc

  const SocialDataUpdatedEvent({required this.updatedLocal});
}
