import 'package:dartz/dartz.dart';
import 'package:restaurant_delivery/core/errors/failures.dart';
import 'package:restaurant_delivery/domain/entities/product.dart';
import 'package:restaurant_delivery/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
