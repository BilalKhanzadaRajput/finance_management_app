import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:fm_app/presentation/screens/homeScreens/expenses_screen.dart';

class InputSalaryScreen extends StatefulWidget {
  const InputSalaryScreen({super.key});

  @override
  State<InputSalaryScreen> createState() => _InputSalaryScreenState();
}

class _InputSalaryScreenState extends State<InputSalaryScreen> {
  String? selectedUserType;
  final TextEditingController salaryRangeController = TextEditingController();

  final List<String> userTypes = [
    'Businessman',
    'Employee',
    'Freelancer',
    'Student',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: Text(
          'User Salary Input',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select User Type',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.PRIMARY_COLOR,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorResources.PRIMARY_COLOR,
                          width: 1.5.w,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedUserType,
                          isExpanded: true,
                          hint: const Text('Choose User Type'),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          dropdownColor: Colors.white,
                          items: userTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedUserType = newValue;
                            });
                          },
                          style: TextStyle(
                            color: ColorResources.PRIMARY_COLOR,
                            fontSize: 16.sp,
                          ),
                          iconEnabledColor: ColorResources.PRIMARY_COLOR,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Enter Monthly Salary Range',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.PRIMARY_COLOR,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: salaryRangeController,
                      decoration: InputDecoration(
                        hintText:
                            'Enter Salary Range (e.g., ₨100,000 - ₨200,000)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: ColorResources.PRIMARY_COLOR,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (selectedUserType != null &&
                              salaryRangeController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpensesScreen(
                                    salaryRange: salaryRangeController.text),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select a user type and enter a salary range',
                                ),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        label: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.PRIMARY_COLOR,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 15.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
