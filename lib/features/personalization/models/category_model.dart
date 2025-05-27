class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String thumbnail;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  // Factory constructor để tạo một CategoryModel từ JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  // Phương thức để chuyển đổi CategoryModel thành JSON (tùy chọn, nếu bạn cần gửi dữ liệu này)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
    };
  }
}