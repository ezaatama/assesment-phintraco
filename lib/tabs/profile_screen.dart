import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phintraco_assesment/data/auth/login/login_cubit.dart';
import 'package:phintraco_assesment/data/profile/data_profile/profile_cubit.dart';
import 'package:phintraco_assesment/utils/constant.dart';
import 'package:phintraco_assesment/widget/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>();
    final auth = context.read<LoginCubit>();
    if (auth.isLogin == true) {
      profile.getDataProfile(auth.user!.id!);
    }

    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        backgroundColor: ColorUI.PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          "Profile",
          style: WHITE_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileEmpty) {
                return const Center(child: Text("Data profile kosong"));
              } else if (state is ProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/icons/reza.jpg",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(state.user.name,
                          style: BLACK_TEXT_STYLE.copyWith(
                              fontSize: 18,
                              fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    ),
                    const SizedBox(height: 15),
                    const Divider(thickness: 2, color: ColorUI.PRIMARY_COLOR),
                    const SizedBox(height: 5),
                    Text("Nama",
                        style: SECONDARY_TEXT_STYLE.copyWith(
                            fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM)),
                    Text(state.user.name,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    _divider(),
                    Text("Email",
                        style: SECONDARY_TEXT_STYLE.copyWith(
                            fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM)),
                    Text(state.user.email,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    _divider(),
                    Text("No. Handphone",
                        style: SECONDARY_TEXT_STYLE.copyWith(
                            fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM)),
                    Text(state.user.noHandphone,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    _divider(),
                    Text("Agama",
                        style: SECONDARY_TEXT_STYLE.copyWith(
                            fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM)),
                    Text(state.user.religion,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    _divider(),
                    Text("Tanggal Lahir",
                        style: SECONDARY_TEXT_STYLE.copyWith(
                            fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM)),
                    Text(state.user.tanggalLahir,
                        style: BLACK_TEXT_STYLE.copyWith(
                            fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                    const SizedBox(height: 10),
                    PrimaryButton(
                        text: "Sign Out",
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        })
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      )),
    );
  }

  Widget _divider() {
    return const Column(
      children: [
        SizedBox(height: 5),
        Divider(thickness: 2, color: ColorUI.PRIMARY_COLOR),
        SizedBox(height: 5),
      ],
    );
  }
}
