import 'package:shoelaundry/core/components/custom_dropdown.dart';
import 'package:shoelaundry/core/components/image_picker_widget.dart';
import 'package:shoelaundry/data/models/request/register_request_model.dart';
import 'package:shoelaundry/presentation/auth/models/roles_model.dart';
import 'package:shoelaundry/presentation/auth/pages/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../home/pages/dashboard_page.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/registration/registration_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  TextEditingController? emailController;
  TextEditingController? phoneContoller;
  XFile? imageFile;
  String role = 'user';
  final List<RolesModel> roles = [
    // RolesModel(name: 'Admin', value: 'admin'),
    RolesModel(name: 'User', value: 'user'),
    // RolesModel(name: 'Staff', value: 'staff'),
  ];

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController!.dispose();
    passwordController!.dispose();
    emailController!.dispose();
    phoneContoller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(50.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Image.asset(
                Assets.images.launcher.path,
                width: 100,
                height: 100,
              )),
          const SpaceHeight(30.0),
          Center(
            child: Text(
                "Selamat Datang di Shoe Laundry!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          Center(
            child: Text(
              "Silakan daftar jika anda belum punya akun.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: usernameController!,
            label: 'Name',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: emailController!,
            label: 'Email',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController!,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: phoneContoller!,
            label: 'Phone',
          ),
          const SpaceHeight(12.0),
          CustomDropdown<RolesModel>(
            value: roles.first,
            items: roles,
            label: "Role",
            onChanged: (value) {
              role = value!.value;
            },
          ),
          const SpaceHeight(12.0),
          ImagePickerWidget(
            label: 'Photo Profile',
            onChanged: (file) {
              if (file == null) {
                return;
              }
              imageFile = file;
            },
          ),
          const SpaceHeight(24.0),
          BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: (authResponseModel) {
                    //scaffold massager delayed
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Akun Berhasil Dibuat"),
                      backgroundColor: AppColors.green,
                    ));

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Lengkapi semua data dengan benar"),
                    ));
                  });
            },
            child: BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        final String name = usernameController!.text;
                        final String email = emailController!.text;
                        final String password = passwordController!.text;
                        final String phone = phoneContoller!.text;
                        final RegisterRequestModel data = RegisterRequestModel(
                            name: name,
                            email: email,
                            password: password,
                            phone: phone,
                            roles: role,
                            image: imageFile!);
                        context
                            .read<RegistrationBloc>()
                            .add(RegistrationEvent.register(data, imageFile!));
                      },
                      label: "Register",
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
          const SpaceHeight(20),
          // BlocConsumer<RegistrationBloc, RegistrationState>(
          //   listener: (context, state) {
          //     state.maybeMap(
          //         orElse: () {},
          //         success: (_) {
          //           Navigator.pop(context);
          //         });
          //   },
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       orElse: () {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       },
          //       loading: () {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       },
          //       success: (_) {
          //         return Button.filled(
          //             onPressed: () {
          //               final String name = usernameController!.text;
          //               final String email = emailController!.text;
          //               final String password = passwordController!.text;
          //               final String phone = phoneContoller!.text;
          //               final RegisterRequestModel data = RegisterRequestModel(
          //                   name: name,
          //                   email: email,
          //                   password: password,
          //                   phone: phone,
          //                   image: imageFile!);
          //               context.read<RegistrationBloc>().add(
          //                     RegistrationEvent.register(data, imageFile!),
          //                   );
          //             },
          //             label: "Simpan");
          //       },
          //     );
          //   },
          // ),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Sudah punya akun?',
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.black, // You can set the color as per your design
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Login Sekarang',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors
                          .primary, // You can set the color as per your design
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                  ),
                ],
              ),
            ),
          ),
          SpaceHeight(40.0),
        ],
      ),
    );
  }
}
