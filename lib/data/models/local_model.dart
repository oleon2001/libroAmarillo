import '../../../domain/entities/local_entity.dart';
import 'social_data_model.dart';

class LocalModel extends LocalEntity {
  const LocalModel({
    required super.id,
    required super.googlePlaceId,
    required super.name,
    required super.category,
    required super.latitude,
    required super.longitude,
    required super.googleRating,
    required super.baseAddress,
    required super.socialStatus,
    super.socialData,
  });

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    SocialStatus parseStatus(String? status) {
      switch (status?.toLowerCase()) {
         case 'loading': return SocialStatus.loading;
         case 'merged': return SocialStatus.merged;
         case 'failed': return SocialStatus.failed;
         default: return SocialStatus.pending;
      }
    }

    final location = json['location'] as Map<String, dynamic>? ?? {};

    return LocalModel(
      id: json['id'] ?? '',
      googlePlaceId: json['googlePlaceId'] ?? '', // Not in example JSON, but in spec
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      latitude: (location['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (location['lng'] as num?)?.toDouble() ?? 0.0,
      googleRating: (json['googleRating'] as num?)?.toDouble() ?? 0.0,
      baseAddress: json['baseAddress'] ?? '',
      socialStatus: parseStatus(json['socialStatus']),
      socialData: json['socialData'] != null
          ? SocialDataModel.fromJson(json['socialData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'googlePlaceId': googlePlaceId,
      'name': name,
      'category': category,
      'location': {
        'lat': latitude,
        'lng': longitude,
      },
      'googleRating': googleRating,
      'baseAddress': baseAddress,
      'socialStatus': socialStatus.name,
      'socialData': socialData != null 
          ? (socialData as SocialDataModel).toJson() 
          : null,
    };
  }
}
