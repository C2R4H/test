import '../../data/network/network_service.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/api_response.dart';

part 'i_categories_repository.dart';

class CategoriesRepository extends ICategoriesRepository{
  final NetworkService networkService = NetworkService();

  @override
  Future<APIResponse<CategoriesModel>> getCategories({required int page,required int pageSize}) async {
    return await networkService.getCategories(page,pageSize);
  }
}
