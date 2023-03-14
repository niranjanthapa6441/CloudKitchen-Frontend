import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/customer_controller.dart';
import '../../route_helper/route_helper.dart';
import '../../utils/Color/colors.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({Key? key}) : super(key: key);

  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDetailController>(builder: (context) {
      return Container(
        child: ListView(children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.height20),
                child: Center(
                  child: AppIcon(
                    icon: Icons.person,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 15,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: context.customer!.firstName.toString(),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: context.customer!.middleName.toString().isEmpty
                        ? 'Middle Name'
                        : context.customer!.middleName.toString(),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.calendar_today_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: DateFormat.yMMMd().format(DateTime.parse(
                        context.customer!.dateOfBirth.toString())),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: context.customer!.lastName.toString(),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.email_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: context.customer!.email.toString(),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: Dimensions.height20,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.phone_android,
                    iconColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 223, 123, 80),
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: context.customer!.phoneNumber.toString(),
                    color: AppColors.textColor,
                    textOverflow: TextOverflow.ellipsis,
                  )),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getUpdaTeProfile());
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width30 + Dimensions.width30 * 3,
                    right: Dimensions.width30 + Dimensions.width30 * 3,
                  ),
                  height: Dimensions.screenHeight / 19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Color.fromARGB(255, 223, 123, 80),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Edit Profile",
                      size: Dimensions.font20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      );
    });
  }
}
