import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/grade_controller.dart';
import '../models/unit_grade.dart';

class GradesManager {
  var tempGrade = UnitGrade();
  var defaultGrade = 'PD Default';
  final storage = GetStorage();
  GradeController gradeController = Get.find<GradeController>();

  bool storeUnitGrade(UnitGrade unitGrade) {
    String unitGradeAsJson = jsonEncode(unitGrade);
    String unitCode = unitGrade.unitId;
    bool returnStatus = true;

    switch (unitCode) {
      case 'A1':
        {
          storage.write('a1grade', unitGradeAsJson);
          gradeController.updateA1(unitGradeAsJson);
        }
        break;

      case 'A2':
        {
          storage.write('a2grade', unitGradeAsJson);
          gradeController.updateA1(unitGradeAsJson);
        }
        break;

      case 'B1':
        {
          storage.write('b1grade', unitGradeAsJson);
          gradeController.updateA1(unitGradeAsJson);
        }
        break;

      case 'B2':
        {
          storage.write('b2grade', unitGradeAsJson);
          gradeController.updateA1(unitGradeAsJson);
        }
        break;

      default:
        returnStatus = false;
        break;
    }

    return returnStatus;
  }

  // -- methods to persist default grades
  // -- grades are built using class UnitGrade
  // -- Data is encoded as Json.
  void storeA1DefaultGrade() {
    tempGrade = tempGrade.defaultGrade('A1', 'A1 Skills Development');
    String unitGradeAsJson = jsonEncode(tempGrade);
    //storage.write('a1grade', unitGradeAsJson);
    gradeController.updateA1(unitGradeAsJson);
  }

  void storeA2DefaultGrade() {
    tempGrade = tempGrade.defaultGrade('A2', 'A2 Creative Project');
    String unitGradeAsJson = jsonEncode(tempGrade);
    //storage.write('a2grade', unitGradeAsJson);
    gradeController.updateA2(unitGradeAsJson);
  }

  void storeB1DefaultGrade() {
    tempGrade = tempGrade.defaultGrade('B1', 'B1 Personal Progression');
    String unitGradeAsJson = jsonEncode(tempGrade);
    //storage.write('b1grade', unitGradeAsJson);
    gradeController.updateB1(unitGradeAsJson);
  }

  void storeB2DefaultGrade() {
    tempGrade = tempGrade.defaultGrade('B2', 'B2 Industry Response');
    String unitGradeAsJson = jsonEncode(tempGrade);
    //storage.write('b2grade', unitGradeAsJson);
    gradeController.updateB2(unitGradeAsJson);
  }
}
