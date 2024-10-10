import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noon/common/theme/app_colors.dart';
import 'package:noon/features/home/cubit/cart_cubit.dart';
import 'package:noon/features/home/widgets/counter_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getCartItems;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartUpdated) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.soft200, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                state.cartItems[index].product.image,
                                width: 200,
                                height: 150,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.cartItems[index].product.title),
                                  Text(
                                      state.cartItems[index].product.brandName),
                                  CounterWidget(
                                      incremeant: () => context
                                          .read<CartCubit>()
                                          .incrementCounter(
                                              state.cartItems[index].product),
                                      decremeant: () => context
                                          .read<CartCubit>()
                                          .decrementCounter(
                                              state.cartItems[index].product),
                                      value: state.cartItems[index].quantity),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total',
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartUpdated) {
                      return Text(
                        state.totalPrice.toStringAsFixed(2),
                      );
                    } else {
                      return Text(
                        '0',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
