import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Represents a simplified product model with essential details.
class ShortProductManagementModel {
  /// The name of the product.
  final String name;

  /// The highest bid received for the product, as a string.
  final String highestBid;

  /// The path to the product's image.
  final String image;

  /// A unique slug for the product, often used in URLs.
  final String slug;

  /// The start date and time of the auction.
  final DateTime startDate; // <--- Thêm trường startDate

  /// The end date and time of the auction.
  final DateTime endDate;   // <--- Thêm trường endDate

  /// Constructor for the ShortProductManagementModel class.
  ///
  /// Requires all fields to be provided.
  ShortProductManagementModel({
    required this.name,
    required this.highestBid,
    required this.image,
    required this.slug,
    required this.startDate, // <--- Thêm vào constructor
    required this.endDate,   // <--- Thêm vào constructor
  });

  factory ShortProductManagementModel.fromJson(Map<String, dynamic> json) {
    final String imageDomain = dotenv.env['API_IMAGE_BASE_URL'] ?? 'https://default-domain.com/'; // Giá trị mặc định nếu không tìm thấy

    final String imageName = json['image'] as String;
    final String fullImageUrl = imageDomain + imageName;

    return ShortProductManagementModel(
      name: json['name'] as String,
      highestBid: json['highest_bid'] as String,
      image: fullImageUrl,
      slug: json['slug'] as String,
      // Phân tích cú pháp chuỗi ngày tháng thành DateTime
      startDate: DateTime.parse(json['start_date'] as String), // <--- Phân tích cú pháp startDate
      endDate: DateTime.parse(json['end_date'] as String),     // <--- Phân tích cú pháp endDate
    );
  }

  /// Converts the ShortProductManagementModel instance to a JSON map.
  ///
  /// This can be useful for serializing the object back into a format
  /// suitable for storage or network transmission.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'highest_bid': highestBid,
      'image': image,
      'slug': slug,
      'start_date': startDate.toIso8601String(), // <--- Chuyển đổi DateTime về chuỗi ISO 8601
      'end_date': endDate.toIso8601String(),     // <--- Chuyển đổi DateTime về chuỗi ISO 8601
    };
  }

  @override
  String toString() {
    return 'ShortProductManagementModel(name: $name, highestBid: $highestBid, image: $image, slug: $slug, startDate: $startDate, endDate: $endDate)';
  }
}