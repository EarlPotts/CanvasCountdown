import 'package:canvas_countdown/APIUse.dart';
import 'package:canvas_countdown/assignmentCard.dart';
import 'package:canvas_countdown/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String coursesResponse = "";
  bool loading;
  List<Widget> coursesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getCoursesResp();
  }

  void getCoursesResp() async{
    List<Course> courses = await getCourses();
    coursesList = [];

    for(Course c in courses){
      coursesList.add(ListTile(
        title: Text(c.name)
      ));
      List<Assignment> assignments = await getAssignments(c.courseId);
      for(Assignment a in assignments){
        coursesList.add(AssignmentCard(a));
      }


    }

    setState(() {
      loading = false;
      //coursesResponse = resp.body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Canvas Countdown'
        ),
        backgroundColor: burntOrange,
      ),
      body: SafeArea(
        child: buildChecklist(),
      ),
    );
  }

  Widget buildChecklist(){
    if(loading){
      return CircularProgressIndicator();
    } else {
      return Container(
        child: ListView(
          children: coursesList,
        ),
      );
    }
  }
}
