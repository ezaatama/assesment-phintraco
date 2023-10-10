import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phintraco_assesment/data/auth/login/login_cubit.dart';
import 'package:phintraco_assesment/utils/constant.dart';
import 'package:phintraco_assesment/utils/extension.dart';
import 'package:phintraco_assesment/widget/custom_text_field.dart';
import 'package:phintraco_assesment/widget/loading_button.dart';
import 'package:phintraco_assesment/widget/primary_button.dart';
import 'package:phintraco_assesment/widget/suffix_icon.dart';
import 'package:phintraco_assesment/widget/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    const Expanded(flex: 1, child: SizedBox()),
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
              Center(
                child: Image.asset("assets/icons/logo_phintraco.png",
                    fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  "assets/icons/ic_attendance.png",
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .200,
                ),
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
              const SizedBox(height: 15),
              InkWell(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.end,
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                ),
              ),
              const SizedBox(height: 5),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    showToast(
                        text: state.loginSuccess, state: ToastStates.SUCCESS);
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  if (state is LoginErrorUser) {
                    showToast(
                        text: state.loginErrUser, state: ToastStates.ERROR);
                  }
                  if (state is LoginError) {
                    showToast(text: state.loginErr, state: ToastStates.ERROR);
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<LoginCubit>();
                  return cubit.isLogin
                      ? LoadingButton(onPressed: () {
                          debugPrint("Loading Response");
                        })
                      : PrimaryButton(
                          text: "Sign In",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context.read<LoginCubit>().loginUser(
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          });
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_LIGHT),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "Register",
                      style: BLACK_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
