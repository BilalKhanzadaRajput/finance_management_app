import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

class InputSalaryScreen extends StatefulWidget {
  const InputSalaryScreen({super.key});

  @override
  State<InputSalaryScreen> createState() => _InputSalaryScreenState();
}

class _InputSalaryScreenState extends State<InputSalaryScreen> {
  String? selectedUserType;
  String? selectedSalaryRange;

  final List<String> userTypes = [
    'Businessman',
    'Employee',
    'Freelancer',
    'Student',
  ];

  final List<String> salaryRanges = [
    'Below ₨100,000',
    '₨100,000 - ₨200,000',
    '₨200,000 - ₨300,000',
    '₨300,000 - ₨500,000',
    'Above ₨500,000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0, // No shadow under AppBar
        backgroundColor: ColorResources.PRIMARY_COLOR, // Primary color for the AppBar
        title: Text(
          'User Salary Input',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp, // Responsive font size
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w), // Responsive padding
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r), // Responsive radius
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(20.w), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select User Type',
                      style: TextStyle(
                        fontSize: 18.sp, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: ColorResources.PRIMARY_COLOR
                      ),
                    ),
                    SizedBox(height: 10.h), // Responsive spacing
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorResources.PRIMARY_COLOR,
                          width: 1.5.w, // Responsive border width
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
                            fontSize: 16.sp, // Responsive font size
                          ),
                          iconEnabledColor: ColorResources.PRIMARY_COLOR,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      'Select Monthly Salary Range',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.PRIMARY_COLOR
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
                          value: selectedSalaryRange,
                          isExpanded: true,
                          hint: const Text('Choose Salary Range'),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          dropdownColor: Colors.white,
                          items: salaryRanges.map((String range) {
                            return DropdownMenuItem<String>(
                              value: range,
                              child: Text(range),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSalaryRange = newValue;
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
                    SizedBox(height: 30.h),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (selectedUserType != null && selectedSalaryRange != null) {
                            Navigator.pushNamed(
                              context,
                              RoutesName.EXPENSES_SCREEN,
                              arguments: {
                                'userType': selectedUserType,
                                'salaryRange': selectedSalaryRange,
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select a user type and salary range',
                                ),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24.sp, // Responsive icon size
                        ),
                        label: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp, // Responsive font size
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
