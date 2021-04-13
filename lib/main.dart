import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades_lab_getx/controllers/grade_controller.dart';
import 'package:grades_lab_getx/controllers/status_controller.dart';
import 'package:grades_lab_getx/controllers/user_controller.dart';

// - Views

import './views/page_admin.dart';
import './views/page_current.dart';
import './views/page_edit_grade.dart';
import './views/page_login.dart';
import './views/page_settings.dart';
import './views/page_switchboard.dart';
import './views/page_target.dart';
import './views/page_testbed.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  StatusController statusController = Get.put(
    StatusController(),
  );

  GradeController gradeController = Get.put(
    GradeController(),
  );

  UserDataController userDataController = Get.put(
    UserDataController(),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GradesLab',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      // - Named routes
      getPages: [
        GetPage(
          name: '/',
          page: () => MyApp(),
        ),
        GetPage(
          name: '/admin',
          page: () => PageAdmin(),
        ),
        GetPage(
          name: '/current',
          page: () => PageCurrent(),
        ),
        GetPage(
          name: '/edit',
          page: () => PageEditGrade(),
        ),
        GetPage(
          name: '/login',
          page: () => PageLogin(),
        ),
        GetPage(
          name: '/settings',
          page: () => PageSettings(),
        ),
        GetPage(
          name: '/switchboard',
          page: () => PageSwitchboard(),
        ),
        GetPage(
          name: '/target',
          page: () => PageTarget(),
        ),
        GetPage(
          name: '/testbed',
          page: () => PageTestbed(),
        ),
      ],
      home: PageLogin(),
    );
  }
}
