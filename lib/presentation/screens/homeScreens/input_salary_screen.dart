import 'package:flutter/material.dart';
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

  final List<String> userTypes = ['Businessman', 'Employee', 'Freelancer', 'Student'];
  final List<String> salaryRanges = [
    'Below \$1,000',
    '\$1,000 - \$2,000',
    '\$2,000 - \$3,000',
    '\$3,000 - \$5,000',
    'Above \$5,000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  elevation: 0, // Remove shadow under the AppBar for a clean look.
  backgroundColor: ColorResources.PRIMARY_COLOR, // Use primary color
  title: const Text(
    'User Salary Input',
    style: TextStyle(color: Colors.white), // Set text color to white
  ),
  centerTitle: true,
),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorResources.PRIMARY_COLOR, Colors.greenAccent], // Use primary color
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners for the card.
                ),
                elevation: 8, // Add a shadow for a card-like effect.
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select User Type',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorResources.PRIMARY_COLOR, width: 1.5), // Use primary color
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedUserType,
                            isExpanded: true,
                            hint: const Text('Choose User Type'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            dropdownColor: Colors.white, // Background color of the dropdown menu
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
                            style: const TextStyle(color: Colors.teal), // Text color for selected item
                            iconEnabledColor: ColorResources.PRIMARY_COLOR, // Icon color
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Select Monthly Salary Range',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorResources.PRIMARY_COLOR, width: 1.5), // Use primary color
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSalaryRange,
                            isExpanded: true,
                            hint: const Text('Choose Salary Range'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            dropdownColor: Colors.white, // Background color of the dropdown menu
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
                            style: const TextStyle(color: Colors.teal), // Text color for selected item
                            iconEnabledColor: ColorResources.PRIMARY_COLOR, // Icon color
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

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
                                  content: Text('Please select a user type and salary range'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          label: const Text('Next'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorResources.PRIMARY_COLOR, // Use primary color
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
