import 'package:restaurant_delivery/domain/entities/product.dart';

abstract class ProductRepository {
  /// Fetches a list of all products available.
  Future<List<Product>> getAllProducts();

  /// Fetches a product by its unique ID.
  Future<Product?> getProductById(String id);

  /// Adds a new product to the repository.
  Future<void> addProduct(Product product);

  /// Updates an existing product in the repository.
  Future<void> updateProduct(Product product);

  /// Deletes a product by its unique ID.
  Future<void> deleteProduct(String id);

  getProducts() {}
}
