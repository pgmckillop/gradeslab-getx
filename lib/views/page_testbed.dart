import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dropdown_control.dart';
import '../components/dropdown_wrapper.dart';
import '../controllers/status_controller.dart';
import '../controllers/user_controller.dart';
import '../models/unit_grade.dart';
import '../uidata/course_data.dart';

class PageTestbed extends StatefulWidget {
  @override
  _PageTestbedState createState() => _PageTestbedState();
}

class _PageTestbedState extends State<PageTestbed> {
  String _chosenCourse;
  String _chosenProfile;
  String _username;
  String _passcode;

  TextEditingController usernameController = TextEditingController();

  UnitGrade unitGrade = UnitGrade();

  @override
  Widget build(BuildContext context) {
    UserDataController userDataController = Get.find<UserDataController>();
    StatusController statusController = Get.find<StatusController>();

    setState(() {
      _chosenCourse = userDataController.course.toString();
      _chosenProfile = userDataController.target.toString();
      usernameController.text = userDataController.username.toString();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('TESTBED'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('User is ${userDataController.username} with a passcode set of ${userDataController.passcode}'),
              Text('Status is ${statusController.status}'),
              Text('Course ${userDataController.course.toString()}'),
              Text('Target ${userDataController.target}'),
              buildCourseDropdown(),
              buildProfileDropdown(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: usernameController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCourseDropdown() => Container(
        child: DropdownWrapper(
          acLabel: 'Course',
          flexValue1: 2,
          flexValueChild: 5,
          wrapperChild: DropdownControl(
            hintText: 'Choose your course',
            valueSetter: _chosenCourse,
            items: getCourseDropdownItems(),
            onChange: (newValue) {
              setState(() {
                this._chosenCourse = newValue;
              });
            },
          ),
        ),
      );

  Widget buildProfileDropdown() => Container(
        child: DropdownWrapper(
          acLabel: 'Target',
          flexValue1: 2,
          flexValueChild: 5,
          wrapperChild: DropdownControl(
            hintText: 'Choose your target profile',
            valueSetter: _chosenProfile,
            items: getProfileDropdownItems(),
            onChange: (newValue) {
              setState(() {
                this._chosenProfile = newValue;
              });
            },
          ),
        ),
      );
}
