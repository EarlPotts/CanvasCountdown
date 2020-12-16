import 'dart:convert';

import 'package:canvas_countdown/constants.dart';
import 'package:canvas_countdown/main.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

Future<List<Course>> getCourses() async{
  Response response = await get('https://utexas.instructure.com:443/api/v1/courses?enrollment_type=student&enrollment_state=active&state[]=available',
  headers: {
    "Authorization" : "Bearer $earlAccessToken"
  });
  Iterable jsonList = json.decode(response.body);
  List<Course> courses = jsonList.map((tagJson) => Course.fromJson(tagJson)).toList();
  MyApp.log.i(courses.toString());
  return courses;
}

Future<List<Assignment>> getAssignments(int courseId) async{
  String url = "https://utexas.instructure.com:443/api/v1/courses/${courseId}/assignments?bucket=past&order_by=due_at";
  Response response = await get(url,
      headers: {
        "Authorization" : "Bearer $earlAccessToken"
      });
  Iterable jsonList = json.decode(response.body);
  List<Assignment> assignments = jsonList.map((tagJson) => Assignment.fromJson(tagJson)).toList();
  return assignments;
}

class Course{
  final int courseId;
  final String calendarLink, name;

  Course({this.name, this.courseId, this.calendarLink});

  factory Course.fromJson(Map<String, dynamic> json) {
    String unformatedName = json['name'];

    return Course(
      name: unformatedName,
      calendarLink: json['calendar']['ics'],
      courseId: json['id'],
    );
  }

  @override
  String toString() {
    return "\nName: $name ID: $courseId Calendar: $calendarLink \n";
  }
}

class Assignment{
  final int assignmentId, courseId;
  final String name, description, dueDate, assignmentURL;

  Assignment(this.assignmentId, this.courseId, this.name, this.description,
      this.dueDate, this.assignmentURL);

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
        json['id'],
        json['course_id'],
        json['name'],
        json['description'],
        json['due_at'],
        json['html_url']
    );
  }
  @override
  String toString() {
    return "Name: $name Due: $dueDate Description: $description";
  }
}