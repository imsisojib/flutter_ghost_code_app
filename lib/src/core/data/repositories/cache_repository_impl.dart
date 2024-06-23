import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RepositoryCacheImpl implements IRepositoryCache{
  final SharedPreferences sharedPreference;
  RepositoryCacheImpl({required this.sharedPreference});

  @override
  String? fetchToken() {
    return sharedPreference.getString('key_app_session_token');
  }

  @override
  Future<void> saveToken(String token) async{
    await sharedPreference.setString('key_app_session_token', token);
  }

  @override
  int? fetchCurrentUserId() {
    return sharedPreference.getInt("key_current_user_id");
  }

  @override
  Future<void>? saveCurrentUserId(int? id) async{
    await sharedPreference.setInt('key_current_user_id', id??-1);
  }

  @override
  void logout() async{
    await sharedPreference.setInt('key_current_user_id', -1);
    await sharedPreference.setString('key_app_session_token', '');
  }

  @override
  List<String> fetchCartProducts() {
    return sharedPreference.getStringList("key_cart_products")??[];
  }

  @override
  void saveCartProduct(String encodedProduct) {
    var products = fetchCartProducts();
    products.add(encodedProduct);
    updateCartProductsList(products);

  }

  Future<void> updateCartProductsList(List<String> encodedProducts) async {
    await sharedPreference.setStringList("key_cart_products", encodedProducts);
  }

  @override
  Future<void> clearCart() async {
    await sharedPreference.setStringList("key_cart_products", []);
  }

}