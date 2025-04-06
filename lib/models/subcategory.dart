import 'dart:convert';

class Subcategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subCategoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subCategoryName': subCategoryName,
    };
  }

  String toJson() => json.encode(toMap());

  factory Subcategory.fromJson(Map<String, dynamic> map) {
    return Subcategory(
      id: map['_id']?.toString() ?? '',
      categoryId: map['categoryId']?.toString() ?? '',
      categoryName: map['categoryName']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      subCategoryName: map['subCategoryName']?.toString() ?? '',
    );
  }
}
