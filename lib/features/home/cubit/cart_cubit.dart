import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noon/features/home/models/product_model.dart';

import '../../cart/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  int quantity = 1;
  ProductModel? productModel;
  List<CartItem> cartItems = [];
  Set<int> lovedProducts = {};

  CartCubit() : super(CartInitial());

  void toggleItem(ProductModel prodcut) {
    if (lovedProducts.contains(prodcut.id)) {
      lovedProducts.remove(prodcut.id);
    } else {
      lovedProducts.add(prodcut.id);
    }
  }

  // Increment the quantity for a specific product
  void incrementCounter(ProductModel product) {
    final cartItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (cartItemIndex >= 0) {
      cartItems[cartItemIndex].quantity +=
          1; // Increment quantity for the existing product
    } else {
      // If the product is not in the cart, add it with an initial quantity of 1
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    emit(CartUpdated(
        cartItems, calculateTotalPrice())); // Emit updated cart items list
  }

  // Decrement the quantity for a specific product
  void decrementCounter(ProductModel product) {
    final cartItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (cartItemIndex >= 0 && cartItems[cartItemIndex].quantity > 1) {
      cartItems[cartItemIndex].quantity -= 1; // Decrement quantity
      emit(CartUpdated(cartItems, calculateTotalPrice()));
    }
  }

  // Add item to the cart with a specific quantity
  void addItemToCart(ProductModel product, int quantity) {
    final cartItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (cartItemIndex >= 0) {
      cartItems[cartItemIndex].quantity =
          quantity; // Update quantity if product already exists
    } else {
      cartItems.add(CartItem(
          product: product,
          quantity: quantity)); // Add new product with initial quantity
    }

    emit(CartUpdated(cartItems, calculateTotalPrice()));
  }

  // Get the quantity for a specific product in the cart
  int getQuantityForProduct(ProductModel product) {
    final cartItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (cartItemIndex >= 0) {
      return cartItems[cartItemIndex].quantity;
    }

    return 1; // Default quantity for a new product not yet added to the cart
  }

  void removeItemFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    emit(CartUpdated(cartItems, calculateTotalPrice()));
  }

  double calculateTotalPrice() {
    // Calculate the subtotal price of items in the cart
    return cartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void getCartItems() {
    emit(CartUpdated(cartItems, calculateTotalPrice()));
  }

  void singleProductModel(ProductModel product) {
    productModel = product;
  }
}
