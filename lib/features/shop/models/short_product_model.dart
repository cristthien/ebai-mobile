import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Represents a simplified product model with essential details.
class ShortProductModel {
  /// The name of the product.
  final String name;

  /// The highest bid received for the product, as a string.
  final String highestBid;

  /// The path to the product's image.
  final String image;

  /// A unique slug for the product, often used in URLs.
  final String slug;

  /// Constructor for the ShortProductModel class.
  ///
  /// Requires all fields to be provided.
  ShortProductModel({
    required this.name,
    required this.highestBid,
    required this.image,
    required this.slug,
  });

  factory ShortProductModel.fromJson(Map<String, dynamic> json) {
    final String imageDomain = dotenv.env['API_IMAGE_BASE_URL'] ?? 'https://default-domain.com/'; // Giá trị mặc định nếu không tìm thấy

    final String imageName = json['image'] as String;
    final String fullImageUrl = imageDomain + imageName;
    return ShortProductModel(
      name: json['name'] as String,
      highestBid: json['highest_bid'] as String,
      image: fullImageUrl,
      slug: json['slug'] as String,
    );
  }

  /// Converts the ShortProductModel instance to a JSON map.
  ///
  /// This can be useful for serializing the object back into a format
  /// suitable for storage or network transmission.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'highest_bid': highestBid,
      'image': image,
      'slug': slug,
    };
  }

  @override
  String toString() {
    return 'ShortProductModel(name: $name, highestBid: $highestBid, image: $image, slug: $slug)';
  }
}