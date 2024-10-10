part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class QuantityLoaded extends CartState {
  final int quantity;
  QuantityLoaded(this.quantity);
}

class CartUpdated extends CartState {
  final List<CartItem> cartItems;
  double totalPrice;

  CartUpdated(this.cartItems, this.totalPrice);
}
