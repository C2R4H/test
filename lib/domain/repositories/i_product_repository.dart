part of 'product_repository.dart';

abstract class IProductRepository{
  Future<APIResponse<Product>> getProductData(int id);
}
