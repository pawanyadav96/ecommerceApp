import '../../../core/api/api_service.dart';
import '../model/product_model.dart';

class ProductService {

  Future<List<ProductModel>> getProducts({
    required int limit,
    required int skip,
  }) async {

    final data = await ApiService.get(
      'https://dummyjson.com/products?limit=$limit&skip=$skip',
    );

    final List products = data['products'];

    return products
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}