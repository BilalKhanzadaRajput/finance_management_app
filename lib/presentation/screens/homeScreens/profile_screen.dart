import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fm_app/businessLogic/bloc/userProfileScreenBloc/bloc/user_profile_screen_bloc_bloc.dart';
import 'package:fm_app/businessLogic/bloc/userProfileScreenBloc/bloc/user_profile_screen_bloc_event.dart';
import 'package:fm_app/businessLogic/bloc/userProfileScreenBloc/bloc/user_profile_screen_bloc_state.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/helper/constants/image_resources.dart';
import 'package:fm_app/presentation/customWidgets/custom_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return BlocProvider(
      create: (context) => UserProfileBloc()..add(FetchUserProfile()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            'User Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 4.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state.nameUpdateSuccess) {
              showCustomSnackbar(
                context,
                'successful',
                'Name updated successfully!',
                ContentType.success,
              );
            }
          },
          builder: (context, state) {
            if (state.isFetchingProfile) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.profileFetchFailed) {
              return Center(
                child: Text(
                  'Failed to load profile: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            _nameController.text = state.fullName;
            _emailController.text = state.email;
            _phoneController.text = state.phone;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            const AssetImage(ImageResources.PERSONS_ICON),
                        backgroundColor: primaryColor.withOpacity(0.1),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        isEditable: true,
                        icon: Icons.person,
                        color: ColorResources.BLACK_COLOR,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        isEditable: false,
                        icon: Icons.email,
                        color: ColorResources.BLACK_COLOR,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        isEditable: false,
                        icon: Icons.phone,
                        color: ColorResources.BLACK_COLOR,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final newName = _nameController.text.trim();
                          if (newName.isNotEmpty) {
                            context
                                .read<UserProfileBloc>()
                                .add(UpdateUserName(newName));
                          }
                        },
                        child: const Text('Update Name'),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    bool isEditable = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditable,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        prefixIcon: Icon(icon, color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: color.withOpacity(0.1),
      ),
    );
  }
}
