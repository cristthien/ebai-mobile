import 'package:ebai/features/shop/models/short_user_model.dart';

class BidModel {
  final int id;
  final String amount;
  final DateTime createdAt;
  final String auctionSlug;
  final ShortUserModel user; // Sử dụng lại ShortUserModel đã có

  BidModel({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.auctionSlug,
    required this.user,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'] as int,
      amount: json['amount'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      auctionSlug: json['auctionSlug'] as String,
      user: ShortUserModel.fromJson(json['user'] as Map<String, dynamic>), // Parse nested user object
    );
  }
}