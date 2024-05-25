//table: users
class UserModel {
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
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    firstName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phone = json['phone'];
    country = json['country'];
    age = json['age'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth;
    data['address'] = address;
    data['phone'] = phone;
    data['country'] = country;
    data['displayName'] = displayName;
    data['age'] = age;
    return data;
  }
}
