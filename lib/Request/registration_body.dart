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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['email'] = email;
    data['username'] = username;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
