class UpdateProfileRequest {
  String firstName;
  String lastName;
  String middleName;
  String email;
  String phoneNumber;
  String dateOfBirth;

  UpdateProfileRequest(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['dateOfBirth'] = this.dateOfBirth;

    return data;
  }
}
