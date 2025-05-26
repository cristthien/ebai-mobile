
class ShortCategoryModel {
  final int id;
  final String name;
  final String description;

  ShortCategoryModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ShortCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShortCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
