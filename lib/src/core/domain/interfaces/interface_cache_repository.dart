abstract class IRepositoryCache{
  Future<void> saveToken(String token);
  String? fetchToken();
  Future<void>? saveCurrentUserId(int? id);
  int? fetchCurrentUserId();
  List<String> fetchCartProducts();
  void saveCartProduct(String encodedProduct);
  void logout();
}