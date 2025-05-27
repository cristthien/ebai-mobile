import 'dart:convert';

import 'package:ebai/features/shop/models/short_category_model.dart';
import 'package:ebai/features/shop/models/short_user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import để xử lý JSON cho 'specifications'

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String slug;
  final String? brand; // Có thể null
  final String? model; // Có thể null
  final String condition;
  final String? price; // Có thể null
  final DateTime startDate;
  final DateTime endDate;
  final String startingBid;
  final String highestBid;
  final int bidCount;
  final Map<String, dynamic> specifications; // Sẽ parse chuỗi JSON thành Map
  final List<String> images; // List of image paths/URLs
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final ShortCategoryModel category;
  final ShortUserModel user;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    this.brand,
    this.model,
    required this.condition,
    this.price,
    required this.startDate,
    required this.endDate,
    required this.startingBid,
    required this.highestBid,
    required this.bidCount,
    required this.specifications,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.category,
    required this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Xử lý 'specifications' từ chuỗi JSON sang Map<String, dynamic>
    Map<String, dynamic> parsedSpecifications = {};
    if (json['specifications'] != null && json['specifications'] is String) {
      try {
        parsedSpecifications = jsonDecode(json['specifications']);
      } catch (e) {
        print('Error parsing specifications JSON: $e');
        // Xử lý lỗi parse, có thể để Map rỗng hoặc log
      }
    }

    // Xử lý 'images' để thêm domain (nếu cần, dùng dotenv như bạn đã làm)
    // Giả sử dotenv đã được load trong main.dart
    final String imageDomain = dotenv.env['API_IMAGE_BASE_URL'] ?? 'https://default-domain.com/'; // <-- Dùng domain từ .env
    List<String> fullImageUrls = [];
    if (json['images'] != null && json['images'] is List) {
      fullImageUrls = (json['images'] as List)
          .map((imagePath) {
        if (imagePath is String) {
          // Kiểm tra nếu đường dẫn đã là URL đầy đủ (ví dụ: http/https)
          if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
            return imagePath;
          }
          return imageDomain + imagePath; // Nối domain vào đường dẫn tương đối
        }
        return ''; // Trả về chuỗi rỗng hoặc xử lý lỗi nếu không phải String
      })
          .where((url) => url.isNotEmpty) // Lọc bỏ các chuỗi rỗng
          .toList();
    }


    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      slug: json['slug'] as String,
      brand: json['brand'] as String?, // Dùng `as String?` vì có thể null
      model: json['model'] as String?, // Dùng `as String?` vì có thể null
      condition: json['condition'] as String,
      price: json['price'] as String?, // Dùng `as String?` vì có thể null
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      startingBid: json['starting_bid'] as String,
      highestBid: json['highest_bid'] as String,
      bidCount: json['bid_count'] as int,
      specifications: parsedSpecifications,
      images: fullImageUrls,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String,
      category: ShortCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      user: ShortUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
