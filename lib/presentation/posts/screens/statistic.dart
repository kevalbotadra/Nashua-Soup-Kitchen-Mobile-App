import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/statistic/statistic_bloc.dart';
import 'package:nsks/logic/blocs/statistic/statistic_state.dart';
import 'package:nsks/presentation/posts/widgets/player_statistic.dart';
import 'package:nsks/presentation/widgets/generics/loading_screen.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatisticBloc, StatisticState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ObtainedStats) {
            return StatisticView(users: state.users);
          }

          return NSKSLoading();
        });
  }
}

class StatisticView extends StatelessWidget {
  final List<NsksUser> users;
  const StatisticView({Key? key, required this.users}) : super(key: key);


  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    bool statisticAvailable = true;

    List<NsksUser> runnerUps = users.sublist(3);

    return Scaffold(
      extendBody: true,
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Hours Leaderboard",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: const Color(0xffFFFFFF)),
          ),
        ),
        backgroundColor: COLOR_GREEN,
      ),
      body: statisticAvailable == false
          ? Center(child: Text("This feature is currently unavailable."))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50, left: 175),
                          child: Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("3",
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: COLOR_BROWN.withOpacity(0.5),
                                          spreadRadius: 8,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: COLOR_GREY,
                                      backgroundImage:
                                          NetworkImage(users[2].pfpUrl),
                                      radius: 55,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(users[2].name.split(" ")[0],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: COLOR_BLACK,
                                        )),
                                  ),
                                  Text(removeDecimalZeroFormat(users[2].hours),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: COLOR_GREEN,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50, right: 175),
                          child: Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("2",
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: COLOR_BROWN.withOpacity(0.5),
                                          spreadRadius: 8,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: COLOR_GREY,
                                      backgroundImage:
                                          NetworkImage(users[1].pfpUrl),
                                      radius: 55,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(users[1].name.split(" ")[0],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: COLOR_BLACK,
                                        )),
                                  ),
                                  Text(removeDecimalZeroFormat(users[1].hours),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: COLOR_GREEN,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/crown.png",
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  elevation: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: COLOR_GREEN.withOpacity(0.5),
                                          spreadRadius: 8,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: COLOR_GREY,
                                      backgroundImage:
                                          NetworkImage(users[0].pfpUrl),
                                      radius: 60,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(users[0].name.split(" ")[0],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: COLOR_BLACK,
                                      )),
                                ),
                                Text(removeDecimalZeroFormat(users[0].hours),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: COLOR_GREEN,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Runner-Ups",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: COLOR_BLACK,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      itemCount: runnerUps.length,
                      itemBuilder: (context, index) {
                        return PlayerStatistc(
                          placement: (index + 4).toString(),
                          name: runnerUps[index].name,
                          hours:
                              removeDecimalZeroFormat(runnerUps[index].hours),
                          imageUrl: runnerUps[index].pfpUrl,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
