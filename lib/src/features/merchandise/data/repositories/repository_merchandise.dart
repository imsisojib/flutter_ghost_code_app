import 'package:flutter_boilerplate_code/src/config/config_firebase.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';

class RepositoryMerchandise implements IRepositoryMerchandise {
  final IFirebaseInterceptor firebaseInterceptor;

  RepositoryMerchandise({
    required this.firebaseInterceptor,
  });

  @override
  Future<ApiResponse> fetchProductsByType(String type) async {
    ApiResponse apiResponse = ApiResponse();
    var querySnapshots = await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableShop).where(
      "type",
      isEqualTo: type,
    ).get();
    if(querySnapshots.docs.isNotEmpty){
      apiResponse.statusCode = 200;
      apiResponse.data = querySnapshots.docs;
      apiResponse.message = "Successful";
    }else{
      apiResponse.statusCode = 404;
      apiResponse.message = "No data found!";
    }

    return apiResponse;
  }
}
