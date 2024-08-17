import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/order.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  final Function? onSelect;

  const OrderTile({
    super.key,
    this.onSelect,
    required this.order,
  });

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  String _generateProductsDetail(List<CartProduct>? products) {
    String orderDetails = "";
    if (products?.isEmpty ?? true) {
      return orderDetails;
    }
    for (int i = 0; i < products!.length; i++) {
      orderDetails += "${products[i].name} (${products[i].size}), Quantity: ${products[i].quantity}";
      if (i != products.length - 1) {
        orderDetails += "\n";
      }
    }
    return orderDetails;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        widget.onSelect?.call();
      },
      child: DottedBorder(
        padding: EdgeInsets.zero,
        strokeWidth: 4.w,
        dashPattern: const [4, 4],
        radius: const Radius.circular(6),
        color: AppColors.secondaryColorLight.withOpacity(.8),
        borderType: BorderType.RRect,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.primaryColorLight.withOpacity(.5),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryColorLight.withOpacity(.8),
                    ),
                  ),
                  Text(
                    "${widget.order.total}",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products: ",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryColorLight.withOpacity(.8),
                    ),
                  ),
                  Text(
                    _generateProductsDetail(widget.order.products),
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
