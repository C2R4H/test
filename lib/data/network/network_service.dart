import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/moreToExplore_model.dart';
import '../models/bestSelling_model.dart';
import '../models/categories_model.dart';
import '../models/product_model.dart';
import '../models/api_response.dart';

import '../static.dart';

class NetworkService {

  //GET METHOD FOR CATEGORIES
  Future<APIResponse<CategoriesModel>> getCategories(int page, int pageSize) async {
    final String getCategoriesApi =
        "${StaticVariables.apiUrl}${StaticVariables.apiCategories}?page=$page&page_size=$pageSize";

    return await http.get(Uri.parse(getCategoriesApi)).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final CategoriesModel categoriesModel =
            CategoriesModel.fromJson(jsonData);
        return APIResponse<CategoriesModel>(data: categoriesModel);
      }
      return APIResponse<CategoriesModel>(
          error: true, errorMessage: "There was an error");
    }).catchError((error) => APIResponse<CategoriesModel>(
        errorMessage: error.toString(), error: true));
  }

  //GET METHOD FOR BEST SELLING PRODUCTS
  Future<APIResponse<BestSellingModel>> getBestSelling({required int page, required int pageSize,String? filter}) async {

    String getBestSellingApi = 
        "${StaticVariables.apiUrl}${StaticVariables.apiProducts}${StaticVariables.apiBestSold}?page=$page&page_size=$pageSize";
    if(filter!=null){
      filter = Uri.encodeComponent(filter);
      getBestSellingApi = 
        "${StaticVariables.apiUrl}${StaticVariables.apiProducts}${StaticVariables.apiBestSold}?${StaticVariables.apiSearch}$filter&page=$page&page_size=$pageSize";
    }

    return await http.get(Uri.parse(getBestSellingApi)).then((data){
      if(data.statusCode == 200){
        final jsonData = jsonDecode(data.body);
        final BestSellingModel bestSellingModel = BestSellingModel.fromJson(jsonData);
        return APIResponse<BestSellingModel>(data: bestSellingModel);
      }
      return APIResponse <BestSellingModel>(error: true, errorMessage: "There was an error");
    }).catchError((error) => APIResponse<BestSellingModel>(errorMessage: error.toString(),error:true));
  }

  //GET METHOD FOR MORE PRODUCTS TO EXPLORE
  Future<APIResponse<MoreToExplore>> getMoreProducts({required int page,required int pageSize,String? filter}) async {
    String getMoreProducts = 
        "${StaticVariables.apiUrl}${StaticVariables.apiProducts}?page=$page&page_size=$pageSize";

    if(filter!=null){
      filter = Uri.encodeComponent(filter);
      getMoreProducts= 
        "${StaticVariables.apiUrl}${StaticVariables.apiProducts}?${StaticVariables.apiSearch}$filter&page=$page&page_size=$pageSize";
    }

    return await http.get(Uri.parse(getMoreProducts)).then((data){
      if(data.statusCode == 200){
        final jsonData = jsonDecode(data.body);
        final MoreToExplore moreToExplore = MoreToExplore.fromJson(jsonData);
        return APIResponse<MoreToExplore>(data: moreToExplore);
      }
      return APIResponse <MoreToExplore>(error: true, errorMessage: "There was an error");
    }).catchError((error) => APIResponse<MoreToExplore>(errorMessage: error.toString(),error:true));

  }

  //GET METHOD PRODUCTS DATA 
  Future<APIResponse<Product>> getProductData(int id) async {
    final String getProductApi= 
        "${StaticVariables.apiUrl}${StaticVariables.apiProducts}/$id";

    return await http.get(Uri.parse(getProductApi)).then((data){
      if(data.statusCode == 200){
        final jsonData = jsonDecode(data.body);
        final Product product = Product.fromJson(jsonData);
        return APIResponse<Product>(data: product);
      }
      return APIResponse<Product>(error: true, errorMessage: "There was an error");
    }).catchError((error) => APIResponse<Product>(errorMessage: error.toString(),error:true));

  }
}

