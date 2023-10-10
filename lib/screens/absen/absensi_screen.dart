import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phintraco_assesment/data/attendances/attendances_cubit.dart';
import 'package:phintraco_assesment/data/attendances/data_attendances_cubit.dart';
import 'package:phintraco_assesment/data/auth/login/login_cubit.dart';
import 'package:phintraco_assesment/models/attendances.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/constant.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<LoginCubit>();
    final attendance = context.read<DataAttendancesCubit>();
    if (auth.isLogin == true) {
      attendance.fetchDataCheckInOut(auth.user!.id!);
    }

    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        backgroundColor: ColorUI.PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          "Absen",
          style: WHITE_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/icons/maps.png", fit: BoxFit.cover),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WFO / OnSite",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<AttendancesCubit, AttendancesState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                debugPrint("tap in");
                                Attendance attendanceIn = Attendance(
                                    id: auth.user!.id!,
                                    userId: auth.user!.id!,
                                    date: DateTime.now(),
                                    dateIn: DateTime.now(),
                                    checkIn: DateTime.now(),
                                    dateOut: DateTime.tryParse(''),
                                    checkOut: DateTime.tryParse(''),
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now());

                                Attendance attendanceOut = Attendance(
                                    id: auth.user!.id!,
                                    userId: auth.user!.id!,
                                    date: attendanceIn.date,
                                    dateIn: attendanceIn.dateIn,
                                    checkIn: attendanceIn.checkIn,
                                    dateOut: DateTime.now(),
                                    checkOut: DateTime.now(),
                                    createdAt: attendanceIn.createdAt,
                                    updatedAt: DateTime.now());
                                if (state.isCheckIn == false) {
                                  context
                                      .read<AttendancesCubit>()
                                      .checkIn(auth.user!, attendanceIn);
                                } else {
                                  context
                                      .read<AttendancesCubit>()
                                      .checkOut(auth.user!, attendanceOut);
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    state.isCheckIn == false
                                        ? "assets/icons/ic_checkIn.png"
                                        : "assets/icons/ic_checkOut.png",
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * .40,
                                    height: MediaQuery.of(context).size.height *
                                        .20,
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  bottom: 45,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Text(
                                        state.isCheckIn == false
                                            ? "Check In"
                                            : "Check Out",
                                        style: WHITE_TEXT_STYLE.copyWith(
                                            fontSize: 16,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                      Text(
                                        formattedTime,
                                        style: WHITE_TEXT_STYLE.copyWith(
                                            fontSize: 25,
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Kamu belum Check ${state.isCheckIn == false ? 'in' : 'out'} hari ini",
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontSize: 18, fontWeight: FontUI.WEIGHT_MEDIUM),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Kamu berada dalam jangkauan",
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontSize: 14, fontWeight: FontUI.WEIGHT_LIGHT),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<DataAttendancesCubit, DataAttendancesState>(
              builder: (context, state) {
                if (state is DataAttendancesLoaded) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.checkInData.map((e) {
                          String formatDateIn = DateFormat.EEEE('id')
                              .format(DateTime.tryParse(e['Date_In'])!);
                          String formatCheckIn = DateFormat.jm()
                              .format(DateTime.tryParse(e['Check_In'])!);
                          String formatCheckOut = DateFormat.jm()
                              .format(DateTime.tryParse(e['Check_Out'])!);
                          String date = DateFormat('dd/M/yyyy')
                              .format(DateTime.tryParse(e['Date'])!);
                          return Column(
                            children: [
                              Text(
                                "Riwayat Absen",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                              ),
                              const SizedBox(height: 10),
                              Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDateIn,
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontUI.WEIGHT_MEDIUM),
                                        ),
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
                                                style:
                                                    BLACK_TEXT_STYLE.copyWith(
                                                        fontWeight: FontUI
                                                            .WEIGHT_MEDIUM)),
                                            const SizedBox(width: 15),
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
                                                style:
                                                    BLACK_TEXT_STYLE.copyWith(
                                                        fontWeight: FontUI
                                                            .WEIGHT_MEDIUM)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(date,
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_MEDIUM)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }).toList()),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      )),
    );
  }
}
