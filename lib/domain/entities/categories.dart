import '../../data/models/categories_model.dart';

class CategoriesEntity{

  CategoriesEntity({
    required this.name,
    required this.icon,
    this.error,
  });

  bool? error;
  String name;
  String icon;
}
