import '../../data/network/network_service.dart';
import '../../data/models/moreToExplore_model.dart';
import '../../data/models/api_response.dart';

part 'i_moreProducts_repository.dart';

class MoreProductsRepository extends IMoreProductsRepository{
  final NetworkService networkService = NetworkService();

  @override
  Future<APIResponse<MoreToExplore>> getMoreProducts({required int page,required int pageSize,String? filter}) async {
    return await networkService.getMoreProducts(page: page,pageSize: pageSize,filter: filter);
  }
}
