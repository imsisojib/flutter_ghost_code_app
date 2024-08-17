class ApiResponse<T>{
  int? statusCode;
  T? data;
  String? message;

  ApiResponse({this.statusCode, this.data, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json){
    statusCode = json["statusCode"];
    try{
      data = json["data"];
    }catch(e){
      //todo
    }
    message = json["message"];
  }

  @override
  String toString() {
    return 'ApiResponse{statusCode: $statusCode, data: $data, message: $message}';
  }
}