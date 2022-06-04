part of 'categories_repository.dart';

abstract class ICategoriesRepository{
  Future<APIResponse<CategoriesModel>> getCategories({required int page,required int pageSize});
}


