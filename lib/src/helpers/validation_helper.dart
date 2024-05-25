class ValidationHelper {
  static bool isValidEmail(String? email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email ?? "");
  }

  static bool isValidPassword(String? password) {
    return password?.isNotEmpty??false;
  }

  static bool isValidPhoneNumber(String? phoneNumber){
    if(phoneNumber?.length!=11) return false;

    String code = phoneNumber!.substring(0,3);
    if(code=="013" || code=="014" || code=="015" || code=="016" || code=="017" || code=="018" || code=="019") return true;

    return false;
  }

  static String? isValidPhoneNumberOnUserInteraction({String? value, required bool isInteracting}){
    if(isInteracting){
      if(value==null) return null;
      if((value.length==1 && value=="0")) {
        return null;
      } else if((value.length==2 && value=="01")) {
        return null;
      }else if(value.length>=3 && value.substring(0,2)=="01"){
        return null;
      }
      else {
        return "Invalid phone number.";
      }

    }else{
      if (!ValidationHelper.isValidPhoneNumber(value)) {
        return "Invalid Phone Number";
      }
    }

    return null;
  }
}
