import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_add_to_cart.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_clear_cart_products.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_cart_products.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_product_hats.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_products_hoodie.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_products_tshirt.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_place_order.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/cart_product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/product.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/enums/e_product_type.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/requstbody/requestbody_checkout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProviderMerchandise extends ChangeNotifier {
  //states
  ELoading? _loading;
  List<Product> _products = [];
  EProductType _productType = EProductType.tshirt;
  List<CartProduct> _cartProducts = [];

  //getters
  ELoading? get loading => _loading;

  List<Product> get products => _products;

  EProductType get productType => _productType;

  List<CartProduct> get cartProducts => _cartProducts;

  //setters
  set loading(ELoading? state) {
    _loading = state;
    notifyListeners();
  }

  set productType(EProductType type) {
    _productType = type;
    notifyListeners();

    switch (type) {
      case EProductType.tshirt:
        {
          fetchProductsTShirt();
          break;
        }
      case EProductType.hoodies:
        {
          fetchProductsHoodie();
          break;
        }
      case EProductType.hat:
        {
          fetchProductsHat();
          break;
        }
      default:
    }
  }

  Future<void> fetchProductsTShirt() async {
    _products.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsTShirt(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _products = response;
      },
    );
    loading = null;
  }

  Future<void> fetchProductsHoodie() async {
    _products.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsHoodie(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _products = response;
      },
    );
    loading = null;
  }

  Future<void> fetchProductsHat() async {
    _products.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsHat(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _products = response;
      },
    );
    loading = null;
  }

  Future<void> fetchCartProducts() async {
    _cartProducts.clear();
    loading = ELoading.loading;
    var result = await UseCaseFetchCartProducts(repositoryCart: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _cartProducts = response;
      },
    );
    loading = null;
  }

  Future<void> addToCart(CartProduct cartProduct) async {
    var result = await UseCaseAddToCart(repositoryCart: sl()).execute(cartProduct);
    result.fold(
      (error) {
        Fluttertoast.showToast(msg: error.message);
      },
      (response) {
        Fluttertoast.showToast(msg: response);
      },
    );
    fetchCartProducts();
  }

  bool findIsThisProductInCart(Product product) {
    int found = _cartProducts.indexWhere((element) => element.id == product.id);
    return found != -1;
  }

  double calculateCheckoutTotal() {
    double total = 0;
    for (var element in _cartProducts) {
      total += (element.price ?? 0)*(element.quantity ?? 0);
    }

    return total;
  }

  Future<void> placeOrder(RequestBodyCheckout request) async {
    var result = await UseCasePlaceOrder(repositoryMerchandise: sl()).execute(request);
    result.fold(
      (error) {
        Fluttertoast.showToast(
          msg: error.message,
        );
      },
      (success) async {
        Fluttertoast.showToast(
          msg: success,
        );

        //clearing cart
        await UseCaseClearCart(repositoryCart: sl()).execute(Empty());
        fetchCartProducts();
      },
    );
  }
}
