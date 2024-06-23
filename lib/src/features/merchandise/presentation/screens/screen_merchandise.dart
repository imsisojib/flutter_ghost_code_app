import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/enums/e_product_type.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/widgets/dialog_add_to_cart.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/widgets/dialog_checkout.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenMerchandise extends StatefulWidget {
  const ScreenMerchandise({super.key});

  @override
  State<ScreenMerchandise> createState() => _ScreenMerchandiseState();
}

class _ScreenMerchandiseState extends State<ScreenMerchandise> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //initially fetching all products related to t-shirts
      context.read<ProviderMerchandise>().productType = EProductType.tshirt;
      context.read<ProviderMerchandise>().fetchCartProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Merchandise",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_left_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Image.asset(
                          AppImages.iconHome,
                          height: 24.h,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_right_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Nick",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Image.asset(
                        AppImages.demoAvatar,
                        height: 24,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Consumer<ProviderMerchandise>(
        builder: (_, providerMerchandise, child) {
          return Background(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          providerMerchandise.productType = EProductType.tshirt;
                        },
                        child: Text(
                          "T-Shirts",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: providerMerchandise.productType == EProductType.tshirt ? AppColors.yellow : null,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          providerMerchandise.productType = EProductType.hoodies;
                        },
                        child: Text(
                          "Hoodies",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: providerMerchandise.productType == EProductType.hoodies ? AppColors.yellow : null,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          providerMerchandise.productType = EProductType.hat;
                        },
                        child: Text(
                          "Hats/Beanies",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: providerMerchandise.productType == EProductType.hat ? AppColors.yellow : null,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     "Admission",
                      //     style: theme.textTheme.bodyMedium,
                      //   ),
                      // ),
                      SizedBox(
                        height: 8.h,
                      ),
                      BasicButton(
                        width: 200,
                        buttonText: "Buy Tickets",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.buyTicketsScreen,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        providerMerchandise.loading == ELoading.fetchingData
                            ? const SizedBox(
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox(
                                height: 180.h,
                                child: providerMerchandise.products.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: providerMerchandise.products.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6,
                                          crossAxisSpacing: 8.w,
                                          mainAxisSpacing: 8.w,
                                        ),
                                        itemBuilder: (_, index) {
                                          return InkWell(
                                            onTap: () {
                                              WidgetHelper.showDialogWithDynamicContent(
                                                content: DialogAddToCart(
                                                  product: providerMerchandise.products[index],
                                                ),
                                              );
                                            },
                                            child: Container(
                                                height: 100.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColorLight.withOpacity(.6),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: providerMerchandise.findIsThisProductInCart(providerMerchandise.products[index])
                                                        ? AppColors.yellow
                                                        : AppColors.primaryColorLight.withOpacity(.6),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.all(8),
                                                child: FittedBox(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: providerMerchandise.products[index].thumb ?? "",
                                                        height: 56.h,
                                                      ),
                                                      SizedBox(
                                                        height: 4.h,
                                                      ),
                                                      Text(
                                                        "\$${providerMerchandise.products[index].price}",
                                                        style: theme.textTheme.labelSmall,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text("No Product Found!"),
                                      ),
                              ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          children: [
                            BasicButton(
                              prefix: Image.asset(
                                AppImages.iconCart,
                                height: 28,
                              ),
                              buttonText: "${providerMerchandise.cartProducts.length}",
                              width: 80.w,
                              buttonTextStyle: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            BasicButton(
                              buttonText: "Checkout",
                              width: 200,
                              onPressed: () {
                                if (providerMerchandise.cartProducts.isEmpty) {
                                  Fluttertoast.showToast(msg: "Your cart is empty.");
                                  return;
                                }

                                WidgetHelper.showDialogWithDynamicContent(
                                  content: const DialogCheckout(),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
