part of 'categories_bloc.dart';

class CategoriesState{}

class CategoriesStateLoading extends CategoriesState{}

class CategoriesStateLoaded extends CategoriesState{
  final CategoriesModel categoriesModel;
  final String? categoryName;
  CategoriesStateLoaded({required this.categoriesModel,this.categoryName});
}

class CategoriesStateError extends CategoriesState{
  final String error;
  CategoriesStateError(this.error);
}

