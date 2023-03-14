import 'package:cloud_kitchen/Request/update_profile_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/show_custom_snack_bar.dart';
import '../../controller/customer_controller.dart';
import '../../utils/Color/colors.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var dateOfBirth = '';
  DateTime _date = DateTime.now();

  bool _dateSelected = false;

  TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(' Update Profile'),
        backgroundColor: Color.fromARGB(255, 223, 123, 80),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        child: ListView(
          children: [
            Column(children: [
              Container(
                height: Dimensions.height25,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: firstNameController,
                hintText: "First Name",
                icon: Icons.person,
                width: Dimensions.width10 * 15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: middleNameController,
                hintText: "Middle Name",
                icon: Icons.person,
                width: Dimensions.width10 * 15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: lastNameController,
                hintText: "Last Name",
                icon: Icons.person,
                width: Dimensions.width10 * 15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.email,
                width: Dimensions.width10 * 15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: phoneNumberController,
                hintText: "Phone Number",
                icon: Icons.phone,
                width: Dimensions.width10 * 15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: _dateController,
                hintText: _dateSelected
                    ? DateFormat.yMMMMd().format(_date)
                    : "MM/DD/YYYY",
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                width: Dimensions.width10 * 15,
                widget: IconButton(
                  onPressed: () {
                    _getDate();
                    setState(() {
                      _dateSelected = true;
                    });
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: Dimensions.height30,
            ),
            GestureDetector(
              onTap: () {
                _Validation();
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width30 + Dimensions.width30,
                    right: Dimensions.width30 + Dimensions.width30,
                    bottom: Dimensions.height50),
                height: Dimensions.screenHeight / 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Color.fromARGB(255, 223, 123, 80),
                ),
                child: Center(
                  child: BigText(
                    text: "Update",
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _Validation() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String middleName = middleNameController.text.trim();
    String email = emailController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    if (firstName.isEmpty) {
      showCustomSnackBar("First Name is Empty", title: "First Name");
    } else if (lastName.isEmpty) {
      showCustomSnackBar("Last Name is Empty", title: "Last Name");
    } else if (email.isEmpty) {
      showCustomSnackBar("Email is Empty", title: "Email");
    } else if (phoneNumber.isEmpty) {
      showCustomSnackBar("Phone Number is Empty", title: "Phone Number");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Invalid Email", title: "Email");
    } else if (!phoneNumber.isPhoneNumber) {
      showCustomSnackBar("In Valid Phone Number", title: "PhoneNumber");
    } else if (phoneNumber.length < 10 || phoneNumber.length > 10) {
      showCustomSnackBar("Phone Number Should be 10", title: "PhoneNumber");
    } else {
      UpdateProfileRequest newUser = UpdateProfileRequest(
          firstName: firstName,
          lastName: lastName,
          middleName: middleName,
          email: email,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth);
      var customerController = Get.find<CustomerDetailController>();
      customerController.updateProfile(newUser).then((status) {
        if (status.isSucces) {
          Get.back();
          Get.find<CustomerDetailController>().getCustomerDetails();
          showCustomSnackBar("The details have been updated",
              title: "Profile Update", color: Colors.green);
        } else {
          if (status.message.toLowerCase() == "bad request") {
            showCustomSnackBar('Password must contain characters',
                title: "Registration", color: Colors.red);
          }
        }
      });
    }
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 2)),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(
                  255, 223, 123, 80), // Change the primary color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _dateSelected = true;
        _date = _pickerDate;
      });
    }
  }
}
