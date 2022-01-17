import 'package:collab/personal_spaces/calender_schedule.dart';
import 'package:collab/personal_spaces/user_checklist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class reportSummary extends StatefulWidget {
  const reportSummary({Key? key}) : super(key: key);

  @override
  _reportSummary createState() => _reportSummary();
}

class _reportSummary extends State<reportSummary> {
  Items item1 = Items(
      title: "Completed task",
      subtitle: "3",
      img: "assets/images/done.png");

  Items item2 = Items(
    title: "Task in progress",
    subtitle: "4",
    img: "assets/images/inprogress.png",
  );

  Items item3 = Items(
    title: "Task Archive",
    subtitle: "4",
    img: "assets/images/archive.png",
  );

  Items item4 = Items(
    title: "Total Task",
    subtitle: "4",
    img: "assets/images/totaltask.png",
  );

  Items item5 = Items(
    title: "Graphing",
    subtitle: "Your Report Summary",
    img: "assets/images/report.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar : AppBar(
          centerTitle: true,
          title : const Text("Project Statistics", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
      body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/personalspaces-ui.webp'),
              fit: BoxFit.cover)),
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.7)
            ])),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    children: myList.map((data) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                          child:
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  data.img,
                                  width: 42,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  data.subtitle,
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data.title,
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                              ],
                            ),)
                      );
                    }).toList()),
              ),
              SizedBox(height: 15),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.all(16),
                height: 150,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item5.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      item5.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      item5.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),

            ]
        ),
      ),)
    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Items({required this.title, required this.subtitle, required this.img});
}