//table: users
class UserModel {
  //model keys
  static const String keyUid = "uid";
  static const String keyFirstName = "firstName";
  static const String keyLastName = "lastName";
  static const String keyEmail = "email";
  static const String keyGender = "gender";
  static const String keyDateOfBirth = "dateOfBirth";
  static const String keyAddress = "address";
  static const String keyPhone = "phone";
  static const String keyAge = "age";
  static const String keyCountry = "country";
  static const String keyDisplayName = "displayName";
  static const String keyProfilePic = "profilePic";

  //variables
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? phone;
  String? country;
  int? age;
  String? displayName;
  String? profilePic;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.country,
    this.address,
    this.phone,
    this.age,
    this.displayName,
    this.profilePic,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json[keyUid];
    firstName = json[keyFirstName];
    firstName = json[keyLastName];
    email = json[keyEmail];
    gender = json[keyGender];
    dateOfBirth = json[keyDateOfBirth];
    address = json[keyAddress];
    phone = json[keyPhone];
    country = json[keyCountry];
    age = json[keyAge];
    displayName = json[keyDisplayName];
    profilePic = json[keyProfilePic];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[keyUid] = uid;
    data[keyFirstName] = firstName;
    data[keyLastName] = lastName;
    data[keyGender] = gender;
    data[keyEmail] = email;
    data[keyDateOfBirth] = dateOfBirth;
    data[keyAddress] = address;
    data[keyPhone] = phone;
    data[keyCountry] = country;
    data[keyDisplayName] = displayName;
    data[keyAge] = age;
    data[keyProfilePic] = profilePic;
    return data;
  }
}
