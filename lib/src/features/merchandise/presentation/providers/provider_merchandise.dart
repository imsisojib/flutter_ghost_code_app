import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_product_hats.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_products_hoodie.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/applications/usecase_fetch_products_tshirt.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/product.dart';
import 'package:flutter_boilerplate_code/src/helpers/debugger_helper.dart';

class ProviderMerchandise extends ChangeNotifier {
  //states
  ELoading? _loading;
  List<Product> _productsByType = [];

  //getters
  ELoading? get loading => _loading;

  List<Product> get productsByType => _productsByType;

  //setters
  set loading(ELoading? state) {
    _loading = state;
  }

  Future<void> fetchProductsTShirt() async {
    _productsByType.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsTShirt(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
      (error) {

      },
      (response) {
        Debugger.debug(
          title: "Fetched TShirts ->",
          data: response.length,
        );
        _productsByType = response;
        notifyListeners();
      },
    );
    loading = null;
  }

  Future<void> fetchProductsHoodie() async {
    //_productsByType.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsHoodie(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
          (error) {

      },
          (response) {
            Debugger.debug(
              title: "Fetched Hoodies ->",
              data: response.length,
            );
        // _productsByType = response;
        // notifyListeners();
      },
    );
    loading = null;
  }

  Future<void> fetchProductsHat() async {
    // _productsByType.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchProductsHat(repositoryMerchandise: sl()).execute(Empty());
    result.fold(
          (error) {

      },
          (response) {
            Debugger.debug(
              title: "Fetched Hats ->",
              data: response.length,
            );
        // _productsByType = response;
        // notifyListeners();
      },
    );
    loading = null;
  }
}
