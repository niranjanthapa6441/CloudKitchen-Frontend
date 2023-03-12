import 'package:cloud_kitchen/controller/order_controller.dart';
import 'package:cloud_kitchen/pages/orders/orders_page_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  List<String> status = ['All', 'Pending', 'Ordered', 'Cancelled'];
  int _selectedIndex = 0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  bool _startDateSelected = false;
  bool _endDateSelected = false;

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Orders'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          Container(
            height: Dimensions.height10 * 5,
            width: Dimensions.screenWidth,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: status.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCategories(index, status[index]);
              },
            ),
          ),
          Row(
            children: [
              AppTextField(
                textEditingController: _startDateController,
                hintText: _startDateSelected
                    ? DateFormat.yMMMMd().format(_startDate)
                    : "MM/DD/YYYY",
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                width: Dimensions.width10 * 15,
                widget: IconButton(
                  onPressed: () {
                    _getStartDate();
                    setState(() {
                      _startDateSelected = true;
                    });
                    _filerOrders();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Color.fromARGB(255, 223, 123, 80),
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.width15,
              ),
              AppTextField(
                textEditingController: _endDateController,
                hintText: _endDateSelected
                    ? DateFormat.yMMMMd().format(_endDate)
                    : "MM/DD/YYYY",
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                width: Dimensions.width10 * 15,
                widget: IconButton(
                  onPressed: () {
                    _getEndDate();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Color.fromARGB(255, 223, 123, 80),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SingleChildScrollView(child: OrdersPageBody())),
        ],
      ),
    );
  }

  Widget _buildCategories(int index, String status) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.height5,
          bottom: Dimensions.height5,
          left: Dimensions.width5,
        ),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10,
        decoration: BoxDecoration(
          color: !isSelected
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 223, 123, 80),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 236, 236),
              blurRadius: Dimensions.radius5,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 249, 248, 248),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 251, 250, 250),
              offset: Offset(5, 0),
            )
          ],
        ),
        child: Center(
            child: BigText(
          text: status,
          size: Dimensions.font15,
          color: !isSelected ? Colors.black : Colors.white,
        )),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _filerOrders();
        });
      },
    );
  }

  _filerOrders() {
    if (_selectedIndex == 0) {
      AppConstant.orderStatus = '';
    } else {
      if (status[_selectedIndex] == 'Pending') {
        AppConstant.orderStatus = 'DELIVERING';
      } else if (status[_selectedIndex] == 'Ordered') {
        AppConstant.orderStatus = 'DELIVERED';
      } else if (status[_selectedIndex] == 'Cancelled') {
        AppConstant.orderStatus = 'CANCELLED';
      }
    }
    if (_startDateSelected == true) {
      AppConstant.startDate = _startDate.toString().substring(0, 10);
    }
    if (_endDateSelected == true) {
      if (_endDate.isAfter(_startDate)) {
        AppConstant.endDate = _endDate.toString().substring(0, 10);
      }
    }
    Get.find<OrderController>().onClose();
    Get.find<OrderController>().get();
  }

  _getStartDate() async {
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
        _startDateSelected = true;
        _startDate = _pickerDate;
        _filerOrders();
      });
    }
  }

  _getEndDate() async {
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
        _endDateSelected = true;
        _endDate = _pickerDate;
        _filerOrders();
      });
    }
  }

  void _clear() {
    AppConstant.startDate = '';

    AppConstant.endDate = '';

    AppConstant.orderStatus = '';

    Get.find<OrderController>().onClose();
    Get.find<OrderController>().get();
  }
}
