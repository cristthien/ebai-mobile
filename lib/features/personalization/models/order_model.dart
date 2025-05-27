import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Represents an order model with flattened auction details.
class OrderModel {
  /// The unique identifier of the order.
  final int id;

  /// The ID of the user who placed the order.
  final String userID;

  /// The total amount of the order, as a string.
  final String amount;

  /// The current status of the order (e.g., "pending", "completed").
  final String status;

  /// The date and time when the order was created.
  final DateTime createdAt;

  /// The date and time when the order was paid. Null if not yet paid.
  final DateTime? paidAt;

  /// The payment method used for the order. Null if not yet paid.
  final String? paymentMethod;

  /// The shipping address for the order. Null if not provided.
  final String? address;

  /// The phone number for the order. Null if not provided.
  final String? phoneNumber;

  // Flattened Auction Details
  /// The ID of the auction associated with this order.
  final int auctionId;

  /// The slug of the auction product.
  final String auctionSlug;

  /// The main image URL of the auction product.
  final String auctionImage;

  /// The highest bid received for the auction product, as a string.
  final String auctionName; // Assuming highest_bid is not directly in the auction object in the provided JSON, if it was, you'd pull it from there.

  /// Constructor for the OrderModel class.
  ///
  /// Requires all non-nullable fields to be provided.
  OrderModel({
    required this.id,
    required this.userID,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.paidAt,
    this.paymentMethod,
    this.address,
    this.phoneNumber,
    required this.auctionId,
    required this.auctionSlug,
    required this.auctionImage,
    required this.auctionName,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final String imageDomain = dotenv.env['API_IMAGE_BASE_URL'] ?? 'https://default-domain.com/'; // Default value if not found

    // Extract auction details from the nested 'auction' map
    final Map<String, dynamic> auctionJson = json['auction'] as Map<String, dynamic>;
    final List<dynamic> imagesList = auctionJson['images'] as List<dynamic>;

    // Get the first image as the main auction image, if available
    final String auctionImageName = imagesList.isNotEmpty ? imagesList.first as String : '';
    final String fullAuctionImageUrl = imageDomain + auctionImageName;

    return OrderModel(
      id: json['id'] as int,
      userID: json['userID'] as String,
      amount: json['amount'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt'] as String) : null,
      paymentMethod: json['paymentMethod'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      // Directly assign flattened auction details
      auctionId: auctionJson['id'] as int,
      auctionSlug: auctionJson['slug'] as String,
      auctionImage: fullAuctionImageUrl,
      // NOTE: 'highest_bid' is NOT directly available in the 'auction' object in your provided JSON sample.
      // If 'highest_bid' needs to come from the auction, you'd need to ensure it's in the 'auction' JSON.
      // For now, I'm setting a placeholder or you'd need to get it from another part of your API response.
      auctionName: auctionJson['name'] as String, // Using order amount as a placeholder for highest bid
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, userID: $userID, amount: $amount, status: $status, createdAt: $createdAt, paidAt: $paidAt, paymentMethod: $paymentMethod, address: $address, phoneNumber: $phoneNumber, auctionId: $auctionId, auctionSlug: $auctionSlug, auctionImage: $auctionImage)';
  }
}