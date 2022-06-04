part of 'categories_bloc.dart';

class CategoriesEvent{
}

class CategoriesEventGet extends CategoriesEvent{
  int page;
  int pageSize;
  CategoriesEventGet({required this.page,required this.pageSize});
}
class CategoriesChoosed extends CategoriesEvent{
  final CategoriesModel categoriesModel;
  final String categoryName;
  CategoriesChoosed(this.categoryName,this.categoriesModel);
}
