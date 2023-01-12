class CategoryModel {
  final String name;
  CategoryModel({required this.name});

  toJson() {
    return {
      'name': name,
    };
  }
}
