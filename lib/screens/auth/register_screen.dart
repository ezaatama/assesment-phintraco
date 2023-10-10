import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phintraco_assesment/data/auth/regist/register_cubit.dart';
import 'package:phintraco_assesment/models/gender.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/constant.dart';
import 'package:phintraco_assesment/utils/extension.dart';
import 'package:phintraco_assesment/widget/custom_gender.dart';
import 'package:phintraco_assesment/widget/custom_text_field.dart';
import 'package:phintraco_assesment/widget/loading_button.dart';
import 'package:phintraco_assesment/widget/primary_button.dart';
import 'package:phintraco_assesment/widget/suffix_icon.dart';
import 'package:phintraco_assesment/widget/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorUI.WHITE,
        appBar: AppBar(
          backgroundColor: ColorUI.WHITE,
          elevation: 0,
          title: Text("Registrasi",
              style: BLACK_TEXT_STYLE.copyWith(
                  fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: ColorUI.BLACK,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _bodyContent());
  }

  Widget _bodyContent() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUI.WHITE,
      body: SafeArea(child: LayoutBuilder(builder: (context, constraint) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _formContent(),
                    const Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
        );
      })),
    );
  }

  Widget _formContent() {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Name",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama wajib diisi!';
                  }
                  return null;
                },
                hintText: "Name",
              ),
              const SizedBox(height: 10),
              Text(
                "Email",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email wajib diisi!';
                  } else if (!isValidEmail(value)) {
                    return 'Masukkan email yang benar!';
                  }
                  return null;
                },
                hintText: "Email",
              ),
              const SizedBox(height: 10),
              Text(
                "Password",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_isObscure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password tidak boleh kosong!';
                    }
                    return null;
                  },
                  suffixIcon: IconSuffixButton(
                    isObscure: _isObscure,
                    onPressed: () {
                      setState(
                        () {
                          _isObscure = !_isObscure;
                        },
                      );
                    },
                  ),
                  onFieldSubmitted: (value) {}),
              const SizedBox(height: 10),
              Text(
                "Tanggal Lahir",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _tglLahirController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal lahir wajib diisi!';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                hintText: "Tanggal lahir",
              ),
              const SizedBox(height: 10),
              Text(
                "No. Handphone",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'No. Hp wajib diisi!';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                hintText: "No. HP",
              ),
              const SizedBox(height: 10),
              Text(
                "Agama",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              UserResponse.agama.isNotEmpty
                  ? DropdownButtonFormField2<String>(
                      hint: Text("Agama",
                          style: BLACK_TEXT_STYLE.copyWith(
                              color: ColorUI.BLACK.withOpacity(.30),
                              fontSize: 14)),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                      buttonStyleData: const ButtonStyleData(
                        height: 60,
                        padding: EdgeInsets.only(right: 10),
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BLACK.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorUI.BLACK.withOpacity(.30)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: ColorUI.WHITE,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Agama wajib diisi!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? value) {
                        if (value!.isEmpty) {
                          UserResponse.religionOption = value.toString();
                        } else {
                          UserResponse.religionOption = value;
                          print(value);
                        }
                      },
                      value: UserResponse.religionOption.isEmpty
                          ? 'Islam'
                          : UserResponse.religionOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          UserResponse.religionOption = newValue!;
                        });
                      },
                      items: UserResponse.agama.map((String e) {
                        return DropdownMenuItem<String>(
                            value: e,
                            child:
                                Text(e, style: const TextStyle(fontSize: 14)));
                      }).toList())
                  : const SizedBox(),
              const SizedBox(height: 10),
              Text(
                "Jenis Kelamin",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 95,
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomGender(
                            item: RadioGenderModel.gender[0],
                            value: 1,
                            groupValue: RadioGenderModel.genderValue,
                            onChanged: (int? value) {
                              setState(() {
                                RadioGenderModel.genderValue = value!;
                              });
                              print(value);
                            }),
                      ),
                      Flexible(
                        child: CustomGender(
                            item: RadioGenderModel.gender[1],
                            value: 2,
                            groupValue: RadioGenderModel.genderValue,
                            onChanged: (int? value) {
                              setState(() {
                                RadioGenderModel.genderValue = value!;
                              });
                              print(value);
                            }),
                      )
                    ],
                  )),
              const SizedBox(height: 15),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    showToast(
                        text: state.regisSuccess, state: ToastStates.SUCCESS);
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                  if (state is RegisterError) {
                    showToast(text: state.registErr, state: ToastStates.ERROR);
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<RegisterCubit>();
                  return cubit.isRegist
                      ? LoadingButton(onPressed: () {
                          print("Loading Response Register");
                        })
                      : PrimaryButton(
                          text: "Register",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              UserResponse user = UserResponse(
                                  // id: id,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  gender: RadioGenderModel.genderValue == 1
                                      ? "PRIA"
                                      : "WANITA",
                                  religion: UserResponse.religionOption,
                                  noHandphone: _phoneController.text,
                                  tanggalLahir: _tglLahirController.text,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now());

                              await context
                                  .read<RegisterCubit>()
                                  .createUser(user);
                            }
                          });
                },
              )
            ],
          ),
        ));
  }
}
