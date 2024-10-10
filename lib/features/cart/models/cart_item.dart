// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:noon/features/home/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;
  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
