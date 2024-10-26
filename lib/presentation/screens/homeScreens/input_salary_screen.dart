import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../businessLogic/bloc/goalBloc/goal_bloc.dart';

class InputSalaryScreen extends StatefulWidget {
  const InputSalaryScreen({super.key});

  @override
  State<InputSalaryScreen> createState() => _InputSalaryScreenState();
}

class _InputSalaryScreenState extends State<InputSalaryScreen> {
  final TextEditingController salaryRangeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> userTypes = [
    'Businessman',
    'Employee',
    'Freelancer',
    'Student',
  ];

  @override
  void dispose() {
    salaryRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: Text(
          'User Salary Input',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: BlocBuilder<GoalBloc, GoalState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select User Type',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.BLACK_COLOR,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: state.userType != null
                                ? ColorResources.PRIMARY_COLOR
                                : ColorResources.BLACK_COLOR,
                            width: 1.5.w,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.userType,
                            isExpanded: true,
                            hint: Text(
                              'Choose User Type',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16.sp,
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: state.userType != null
                                  ? ColorResources.PRIMARY_COLOR
                                  : ColorResources.BLACK_COLOR,
                            ),
                            dropdownColor: Colors.white,
                            items: userTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    color: ColorResources.BLACK_COLOR,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              context
                                  .read<GoalBloc>()
                                  .add(UpdateUserType(newValue ?? ''));
                            },
                            style: TextStyle(
                              color: state.userType != null
                                  ? ColorResources.PRIMARY_COLOR
                                  : Colors.grey.shade600,
                              fontSize: 16.sp,
                            ),
                            iconEnabledColor: state.userType != null
                                ? ColorResources.PRIMARY_COLOR
                                : ColorResources.BLACK_COLOR,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Enter Monthly Salary Range',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.BLACK_COLOR,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: salaryRangeController,
                          decoration: InputDecoration(
                            hintText:
                                'Enter Salary Range (e.g., ₨100,000 - ₨200,000)',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: ColorResources.PRIMARY_COLOR,
                                width: 1.5.w,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a salary range.';
                            }
                            final regex = RegExp(r'^\d+$');
                            if (!regex.hasMatch(value)) {
                              return 'Please enter numbers only';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            final doubleValue = double.tryParse(value) ?? 0.0;
                            context.read<GoalBloc>().add(UpdateMonthlySalary(doubleValue));
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                state.userType != null) {
                              Navigator.pushNamed(
                                  context, RoutesName.EXPENSES_SCREEN,
                                  arguments: {
                                    'goalBloc': context.read<GoalBloc>(),
                                  });
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
