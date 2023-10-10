import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phintraco_assesment/data/attendances/data_attendances_cubit.dart';
import 'package:phintraco_assesment/data/auth/login/login_cubit.dart';
import 'package:phintraco_assesment/data/profile/data_profile/profile_cubit.dart';
import 'package:phintraco_assesment/models/banner_models.dart';
import 'package:phintraco_assesment/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _currentPage++;
      if (_currentPage >= 3) {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 2500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>();
    final auth = context.read<LoginCubit>();
    final attendance = context.read<DataAttendancesCubit>();
    if (auth.isLogin == true) {
      profile.getDataProfile(auth.user!.id!);
      attendance.fetchDataCheckInOut(auth.user!.id!);
    }
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(color: ColorUI.PRIMARY_COLOR),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      "assets/icons/reza.jpg",
                    ),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileEmpty) {
                      return const Center(child: Text("Data profile kosong"));
                    } else if (state is ProfileLoaded) {
                      return Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.user.name,
                                style: WHITE_TEXT_STYLE.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                            const SizedBox(height: 5),
                            Text("PHINTRACO TECHNOLOGY",
                                style: WHITE_TEXT_STYLE.copyWith(
                                    fontWeight: FontUI.WEIGHT_MEDIUM)),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.notifications),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * .20,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (val) {
                  setState(() {
                    _currentPage = val;
                  });
                },
                itemCount: bannerData.length,
                itemBuilder: (context, index) {
                  BannerModels data = bannerData[index];
                  return Stack(
                    children: [
                      Image.asset(
                        data.image,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            bannerData.length,
                            (index) => _buildDot(index: index),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            //fitur - fitur
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fitur Utama",
                    style: PRIMARY_TEXT_STYLE.copyWith(
                        fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _fiturs(() {
                        debugPrint("go to izin screen");
                      }, "assets/icons/ic_izin.png", "Perizinan"),
                      _fiturs(() {
                        debugPrint("go to hadir screen");
                      }, "assets/icons/ic_kehadiran.png", "Kehadiran"),
                      _fiturs(() {
                        debugPrint("go to activity screen");
                      }, "assets/icons/ic_activity.png", "Activity"),
                      _fiturs(() {
                        debugPrint("go to other screen");
                      }, "assets/icons/ic_other.png", "Lain-lain")
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            debugPrint("lihat semua menu");
                          },
                          child: Text(
                            "Lihat Semua Menu",
                            style: PRIMARY_TEXT_STYLE.copyWith(
                                fontWeight: FontUI.WEIGHT_MEDIUM),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "History Absen",
                    style: PRIMARY_TEXT_STYLE.copyWith(
                        fontSize: 18, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<DataAttendancesCubit, DataAttendancesState>(
                    builder: (context, state) {
                      if (state is DataAttendancesLoaded) {
                        return Column(
                            children: state.checkInData.map((e) {
                          String formatDateIn = DateFormat.EEEE('id')
                              .format(DateTime.tryParse(e['Date_In'] ?? '')!);
                          String formatCheckIn = DateFormat.jm()
                              .format(DateTime.tryParse(e['Check_In'] ?? '')!);
                          String formatCheckOut = DateFormat.jm()
                              .format(DateTime.tryParse(e['Check_Out'] ?? '')!);
                          String date = DateFormat('dd/M/yyyy')
                              .format(DateTime.tryParse(e['Date'] ?? '')!);

                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: ColorUI.GREEN,
                                    width: 3.0,
                                  ),
                                ),
                                color: ColorUI.WHITE),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formatDateIn,
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_MEDIUM)),
                                    Text(date,
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_MEDIUM)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .040,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .020,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: ColorUI.GREEN),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(formatCheckIn,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM)),
                                      ],
                                    ),
                                    Text("Check In",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_MEDIUM)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .040,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .020,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: ColorUI.BLACK),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(formatCheckOut,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM)),
                                      ],
                                    ),
                                    Text("Check Out",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_MEDIUM)),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList());
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  AnimatedContainer _buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 25 : 8,
      decoration: BoxDecoration(
          color: _currentPage == index
              ? ColorUI.PRIMARY_COLOR
              : ColorUI.PRIMARY_COLOR.withOpacity(0.30),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _fiturs(Function()? onTap, String image, String text) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Image.asset(image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .18,
              height: MediaQuery.of(context).size.height * .09),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: PRIMARY_TEXT_STYLE.copyWith(
              fontSize: 12, fontWeight: FontUI.WEIGHT_MEDIUM),
        ),
      ],
    );
  }
}
