import 'package:cloud_kitchen/pages/homepage/homepage_body.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/color/colors.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:cloud_kitchen/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../utils/app_constants/app_constant.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  String _locationMessage = '';

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
      });
      return;
    }

    // Check if we have permission to access the device's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permission has not been granted, request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permission has been permanently denied, show an error message
        setState(() {
          _locationMessage =
              'Location permissions have been permanently denied.';
        });
        return;
      } else if (permission == LocationPermission.denied) {
        // Permission has been denied, show a dialog box to ask for permission again
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Location permissions'),
            content: Text('This app needs access to your location.'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Grant permission'),
                onPressed: () => {
                  Navigator.pop(context),
                  _getCurrentLocation(),
                },
              ),
            ],
          ),
        );
        return;
      }
    }

    // Get the current location
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get the address from the current position
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final Placemark place = placemarks.first;

    // Update the UI with the current address
    setState(() {
      _locationMessage = "${place.street}, ${place.locality}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height50, bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Container(
                      child: BigText(
                        text: _locationMessage,
                        textOverflow: TextOverflow.ellipsis,
                        size: Dimensions.font15,
                        color: Color.fromARGB(255, 137, 136, 136),
                      ),
                      width: Dimensions.width10 * 25,
                    )
                  ]),
                  height: Dimensions.height30,
                  width: Dimensions.width300,
                ),
                Stack(
                  children: [
                    AppConstant.hasValue
                        ? Positioned(
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getCart());
                                AppConstant.toCart = false;
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: Dimensions.height30,
                                color: Color.fromARGB(255, 238, 116, 10),
                              ),
                            ),
                          )
                        : Positioned(
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getCart());
                                AppConstant.toCart = false;
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: Dimensions.height30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    AppConstant.hasValue
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: BigText(
                              text: AppConstant.numberOfItems,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: Dimensions.width10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.mainBlackColor,
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            SmallText(
                              text: "Search For Foods or Restaurants",
                              size: Dimensions.font15,
                              color: AppColors.mainBlackColor,
                            )
                          ],
                        ),
                        height: Dimensions.height50,
                        width: Dimensions.width10 * 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 6,
                                  offset: Offset(1, 8),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getSearchFoods());
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
