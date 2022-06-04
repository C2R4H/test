import '../../data/network/network_service.dart';
import '../../data/models/product_model.dart';
import '../../data/models/api_response.dart';

part 'i_product_repository.dart';

class ProductRepository extends IProductRepository{
  NetworkService _networkService = NetworkService();

  @override
  Future<APIResponse<Product>> getProductData(int id) async {
    return await _networkService.getProductData(id);
  }
}
