import 'package:shoelaundry/core/components/buttons.dart';
import 'package:shoelaundry/core/components/custom_text_field.dart';
import 'package:shoelaundry/presentation/auth/bloc/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/image_picker_widget.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/variables.dart';
import '../../../data/models/request/register_request_model.dart';
import '../../auth/bloc/login/login_bloc.dart';
import '../../auth/models/roles_model.dart';
import '../bloc/update_user/update_user_bloc.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  TextEditingController? emailController;
  TextEditingController? phoneContoller;

  XFile? imageFile;
  String role = '';
  TextEditingController? roleController = TextEditingController();

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneContoller = TextEditingController();
    roleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController!.dispose();
    passwordController!.dispose();
    emailController!.dispose();
    phoneContoller!.dispose();
    roleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kelola User'),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              successWithUserData: (userData) {
                return ListView(
                  padding: EdgeInsets.all(30.0),
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: ClipOval(
                        child: Image.network(
                          '${Variables.imageBaseUrl2}${userData.image}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SpaceHeight(10),
                    Text(
                      ' ${userData.name}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SpaceHeight(5),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.disabled2.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Text(
                          ' ${userData.roles}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SpaceWidth(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceHeight(20),
                        Text(
                          "Informasi Akun",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.disabled2,
                          ),
                        ),
                        SpaceHeight(5),
                        CustomTextFieldContainer(
                          title: 'Username',
                          enabled: false,
                          hintText: '${userData.name}',
                        ),
                        SpaceHeight(5),
                        CustomTextFieldContainer(
                          title: 'Email',
                          enabled: false,
                          hintText: '${userData.email}',
                        ),
                        SpaceHeight(5),
                        CustomTextFieldContainer(
                          title: 'Roles',
                          enabled: false,
                          hintText: '${userData.roles}',
                        ),
                        SpaceHeight(5),
                        CustomTextFieldContainer(
                          title: 'Phone',
                          enabled: false,
                          hintText: '${userData.phone}',
                        ),
                      ],
                    ),
                    SpaceHeight(20),
                    Button.filled(
                      color: AppColors.green,
                      label: 'Edit Profile',
                      textColor: AppColors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider.value(
                              value: BlocProvider.of<UpdateUserBloc>(context),
                              child: AlertDialog(
                                title: Text('Edit Profile'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextFieldContainer(
                                        title: 'Username',
                                        controller: usernameController!,
                                      ),
                                      CustomTextFieldContainer(
                                        title: 'Email',
                                        controller: emailController!,
                                      ),
                                      CustomTextFieldContainer(
                                        title: 'Roles',
                                        controller: roleController!,
                                      ),
                                      CustomTextFieldContainer(
                                        title: 'Phone',
                                        controller: phoneContoller!,
                                      ),
                                      SpaceHeight(10),
                                      ImagePickerWidget(
                                        label: 'Foto Profile',
                                        onChanged: (file) {
                                          if (file == null) {
                                            return;
                                          }
                                          imageFile = file;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Batal'),
                                  ),
                                  BlocConsumer<UpdateUserBloc, UpdateUserState>(
                                    listener: (context, state) {
                                      state.maybeWhen(
                                        orElse: () {},
                                        success: (_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Data user berhasil diubah'),
                                                  backgroundColor:
                                                      AppColors.green));
                                          Navigator.of(context).pop();
                                        },
                                        error: (errorMessage) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(errorMessage),
                                              backgroundColor: AppColors.red,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return ElevatedButton(
                                            onPressed: () {
                                              final String username =
                                                  usernameController!.text;
                                              final String email =
                                                  emailController!.text;
                                              final String role =
                                                  roleController!.text;
                                              final String phone =
                                                  phoneContoller!.text;
                                              final RegisterRequestModel
                                                  registerRequestModel =
                                                  RegisterRequestModel(
                                                name: username,
                                                email: email,
                                                roles: role,
                                                phone: phone,
                                                image: imageFile,
                                              );

                                              context
                                                  .read<UpdateUserBloc>()
                                                  .add(UpdateUserEvent
                                                      .updateUser(
                                                    registerRequestModel,
                                                    imageFile!,
                                                  ));
                                            },
                                            child: Text('Simpan'),
                                          );
                                        },
                                        loading: () {
                                          return ElevatedButton(
                                            onPressed:
                                                null, // Hindari interaksi saat loading
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                );
              },
            );
          },
        ));
  }
}
