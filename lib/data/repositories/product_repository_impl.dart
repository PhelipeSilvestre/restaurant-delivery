import 'package:restaurant_delivery/data/datasources/remote/api_service.dart';
import 'package:restaurant_delivery/domain/entities/product.dart';
import 'package:restaurant_delivery/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl({required this.apiService});

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await apiService.get('/products');
    return (response as List).map((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    final response = await apiService.get('/products/$id');
    return Product.fromJson(response);
  }

  @override
  Future<void> addProduct(Product product) async {
    await apiService.post('/products', data: product.toJson());
  }

  @override
  Future<void> updateProduct(Product product) async {
    await apiService.put('/products/${product.id}', data: product.toJson());
  }

  @override
  Future<void> deleteProduct(String id) async {
    await apiService.delete('/products/$id');
  }

  @override
  getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
