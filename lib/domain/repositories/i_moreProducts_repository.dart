part of 'moreProducts_repository.dart';

abstract class IMoreProductsRepository{
  Future<APIResponse<MoreToExplore>> getMoreProducts({required int page,required int pageSize,String filter});
}
