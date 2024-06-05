import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DialogAddToCart extends StatefulWidget {
  final Product product;

  const DialogAddToCart({
    super.key,
    required this.product,
  });

  @override
  State<DialogAddToCart> createState() => _DialogAddToCartState();
}

class _DialogAddToCartState extends State<DialogAddToCart> {
  int quantity = 1;
  Variant? _selectedVariant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${widget.product.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.cancel),
              ),
            ],
          ),
          widget.product.variants==null? const SizedBox(): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Text("Size"),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.w,
                children: widget.product.variants!.map((e){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        _selectedVariant = e;
                      });
                    },
                    child: Container(
                      //width: 50.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedVariant==e?AppColors.green: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 2.h,
                      ),
                      child: Text("${e.size}",style: theme.textTheme.bodySmall,),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          const Text("Quantity"),
          Container(
            width: 150.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if(quantity<=1){
                      return;
                    }else {
                      quantity--;
                    }
                    setState(() {

                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                ),
                Text("$quantity"),
                IconButton(
                  onPressed: () {
                    if(_selectedVariant?.stock!=null){
                      if(quantity<_selectedVariant!.stock!){
                        quantity++;
                      }else{
                        quantity = _selectedVariant!.stock!;
                        Fluttertoast.showToast(msg: "Reached maximum quantity for this size.");
                      }
                    }else{
                      quantity++;
                    }
                    setState(() {
                    });
                  },
                  icon: Icon(
                    Icons.add_circle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          BasicButton(
            backgroundColor: const Color(0xffAD9898).withOpacity(.6),
            buttonText: "Add to cart",
            onPressed: () {
              if(quantity<=0){
                Fluttertoast.showToast(msg: "Please add quantity.");
                return;
              }
              if(widget.product.variants!=null){
                if(_selectedVariant==null){
                  Fluttertoast.showToast(msg: "Please select size first.");
                  return;
                }
                if(quantity>_selectedVariant!.stock!){
                  Fluttertoast.showToast(msg: "Quantity exit stock limit for this size.");
                  return;
                }
              }
              //else means everything is okay
              CartProduct cartProduct = CartProduct(
                id: widget.product.id,
                name: widget.product.name,
                thumb: widget.product.thumb,
                size: _selectedVariant?.size,
                quantity: quantity,
                price: widget.product.price,
                discountPrice: widget.product.discountPrice,
                type: widget.product.type,
              );
              context.read<ProviderMerchandise>().addToCart(cartProduct);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
