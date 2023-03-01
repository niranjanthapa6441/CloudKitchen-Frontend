class SignUpBody {
  String firstName;
  String lastName;
  String middleName;
  String email;
  String username;
  String dateOfBirth;
  String phoneNumber;
  String password;

  SignUpBody(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.username,
      required this.phoneNumber,
      required this.password,
      required this.dateOfBirth});
      
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}
