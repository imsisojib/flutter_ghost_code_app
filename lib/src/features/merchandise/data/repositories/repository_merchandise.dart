import 'package:flutter_boilerplate_code/src/config/config_firebase.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/entities/order.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/requstbody/requestbody_checkout.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';

class RepositoryMerchandise implements IRepositoryMerchandise {
  final IFirebaseInterceptor firebaseInterceptor;

  RepositoryMerchandise({
    required this.firebaseInterceptor,
  });

  @override
  Future<ApiResponse> fetchProductsByType(String type) async {
    ApiResponse apiResponse = ApiResponse();
    var querySnapshots = await firebaseInterceptor
        .getFirestore()
        .collection(ConfigFirebase.tableShop)
        .where(
          "type",
          isEqualTo: type,
        )
        .get();
    if (querySnapshots.docs.isNotEmpty) {
      apiResponse.statusCode = 200;
      apiResponse.data = querySnapshots.docs;
      apiResponse.message = "Successful";
    } else {
      apiResponse.statusCode = 404;
      apiResponse.message = "No data found!";
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> placeOrder(RequestBodyCheckout request) async {
    ApiResponse apiResponse = ApiResponse();
    String orderId = firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableOrders).doc().id;
    try {
      await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableOrders).doc(orderId).set({
        "orderId": orderId,
        "userId": firebaseInterceptor.getAuth().currentUser?.uid,
        "customerName": request.customerName,
        "phoneNumber": request.phoneNumber,
        "address": request.address,
        "products": request.products.map((e) => e.toJson()).toList(),
        "total": request.total,
      });

      apiResponse.message = "Order is placed successfully.";
      apiResponse.statusCode = 200;
    } catch (e) {
      //if any error
      apiResponse.message = "Unable to place order.";
      apiResponse.statusCode = 501;
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse<List<Order>>> fetchMyOrders() async {
    ApiResponse<List<Order>> apiResponse = ApiResponse();
    var querySnapshots = await firebaseInterceptor
        .getFirestore()
        .collection(ConfigFirebase.tableOrders)
        .where(
          "userId",
          isEqualTo: firebaseInterceptor.getAuth().currentUser?.uid,
        )
        .get();
    if (querySnapshots.docs.isNotEmpty) {
      apiResponse.statusCode = 200;
      apiResponse.data = querySnapshots.docs.map((e) => Order.fromJson(e.data())).toList();
      apiResponse.message = "Successful";
    } else {
      apiResponse.statusCode = 404;
      apiResponse.message = "No data found!";
    }

    return apiResponse;
  }
}
