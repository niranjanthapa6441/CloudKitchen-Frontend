class CustomerDetailResponse {
  String? code;
  String? message;
  Customer? data;

  CustomerDetailResponse({this.code, this.message, this.data});

  CustomerDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Customer.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? role;


  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.email,
      this.phoneNumber});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dateOfBirth = json['dateOfBirth'];
    role = json['role'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['role'] = role;

    return data;
  }
}
