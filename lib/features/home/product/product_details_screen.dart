import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noon/common/constants/assets.dart';
import 'package:noon/features/home/cubit/cart_cubit.dart';

import '../../../common/constants/app_constants.dart';
import '../widgets/counter_widget.dart';
import '../widgets/notify_me_card.dart';
import '../widgets/product_card.dart';
import '../widgets/product_images.dart';
import '../widgets/product_info.dart';
import '../widgets/product_list_tile.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, this.isProductAvailable = true});

  final bool isProductAvailable;

  @override
  Widget build(BuildContext context) {
    final singleItem = context.read<CartCubit>().productModel;
    return Scaffold(
      bottomNavigationBar:
          //isProductAvailable
          // ? CartButton(
          //     price: 140,
          //     press: () {
          //       customModalBottomSheet(
          //         context,
          //         height: MediaQuery.of(context).size.height * 0.92,
          //         child: const ProductBuyNowScreen(),
          //       );
          //     },
          //   )
          // :

          /// If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
        isNotify: false,
        onChanged: (value) {},
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context.read<CartCubit>().toggleItem(singleItem);
                        context.read<CartCubit>().addItemToCart(
                            singleItem, context.read<CartCubit>().quantity);
                      },
                      icon: context
                              .read<CartCubit>()
                              .lovedProducts
                              .contains(singleItem!.id)
                          ? SvgPicture.asset(Assets.svgsBookmark,
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.srcOut))
                          : SvgPicture.asset(Assets.svgsBookmark,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                    );
                  },
                ),
              ],
            ),
            const ProductImages(
              images: [productDemoImg1, productDemoImg2, productDemoImg3],
            ),
            ProductInfo(
              brand: "LIPSY LONDON",
              title: singleItem!.title,
              isAvailable: isProductAvailable,
              description:
                  "A cool gray cap in soft corduroy. Watch me.' By buying cotton products from Lindex, you’re supporting more responsibly...",
              rating: 4.4,
              numOfReviews: 126,
            ),
            // const SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(defaultPadding),
            //     child: ReviewCard(
            //       rating: 4.3,
            //       numOfReviews: 128,
            //       numOfFiveStar: 80,
            //       numOfFourStar: 30,
            //       numOfThreeStar: 5,
            //       numOfTwoStar: 4,
            //       numOfOneStar: 1,
            //     ),
            //   ),
            // ),
            ProductListTile(
              svgSrc: Assets.svgsChat,
              title: "Reviews",
              isShowBottomBorder: true,
              press: () {},
            ),
            BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
                  current is QuantityLoaded || current is CartUpdated,
              builder: (context, state) {
                final quantity =
                    context.read<CartCubit>().getQuantityForProduct(singleItem);
                return SliverToBoxAdapter(
                  child: CounterWidget(
                    incremeant: () =>
                        context.read<CartCubit>().incrementCounter(singleItem),
                    decremeant: () =>
                        context.read<CartCubit>().decrementCounter(singleItem),
                    value: quantity,
                  ),
                );
              },
            ),

            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == 4 ? defaultPadding : 0),
                    child: ProductCard(
                      image: productDemoImg2,
                      title: "Sleeveless Tiered Dobby Swing Dress",
                      brandName: "LIPSY LONDON",
                      price: 24.65,
                      priceAfetDiscount: index.isEven ? 20.99 : null,
                      dicountpercent: index.isEven ? 25 : null,
                      press: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
