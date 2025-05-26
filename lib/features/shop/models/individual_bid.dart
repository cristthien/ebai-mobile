class IndividualBid {
  final double amount;
  final String username;
  final DateTime createdAt;

  IndividualBid({required this.amount, required this.username, required this.createdAt});

  factory IndividualBid.fromJson(Map<String, dynamic> json) {
    return IndividualBid(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      username: json['username'] as String? ?? 'N/A',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}