class Category {
  final int id;
  final String category;

  Category({this.id, this.category});

  Category.fromJson(Map<String, dynamic> map)
      : id = map[CategoryMap.id],
        category = map[CategoryMap.category];

  Map<String, dynamic> toJson() => {
        CategoryMap.id: id,
        CategoryMap.category: category,
      };
}

class CategoryMap {
  static const id = 'id';
  static const category = 'category';
}
