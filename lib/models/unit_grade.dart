import 'dart:convert';

class UnitGrade {
  String unitId;
  String unitName;
  String ac1Grade;
  String ac2Grade;
  String ac3Grade;
  String ac4Grade;
  String ac5Grade;

  // Constructor
  UnitGrade({this.unitId, this.unitName, this.ac1Grade, this.ac2Grade, this.ac3Grade, this.ac4Grade, this.ac5Grade});

  // -- method to create an object from a Json string
  // -- Usage
  // ---- Map unitGradeMap = jsonDecode(jsonString);
  // ---- var unitGrade = UnitGradeManager.fromJson(unitGradeMap);
  // ------ Member fields accessible, e.g. unitGrade.unitName
  UnitGrade.fromJson(Map<String, dynamic> json)
      : unitId = json['unitId'],
        unitName = json['unitName'],
        ac1Grade = json['ac1Grade'],
        ac2Grade = json['ac2Grade'],
        ac3Grade = json['ac3Grade'],
        ac4Grade = json['ac4Grade'],
        ac5Grade = json['ac5Grade'];
  // -- Method to create a Json string from an object
  // ---- Usage
  // ---- var unitGrade = new UnitGrade();
  // ---- --> Populate all the fields required
  // ---- String unitGradeAsJson = jsonEncode(unitGrade);
  Map<String, dynamic> toJson() => {
        'unitId': unitId,
        'unitName': unitName,
        'ac1Grade': ac1Grade,
        'ac2Grade': ac2Grade,
        'ac3Grade': ac3Grade,
        'ac4Grade': ac4Grade,
        'ac5Grade': ac5Grade,
      };
  // -- Grade level and status, e.g. 'PW' and 'PF'
  String shortGrade(String gradeString) {
    return gradeString.substring(0, 2).trim();
  }

  // -- Grade as a single letter, such as 'M'
  String gradeLetter(String gradeString) {
    return gradeString.substring(0, 1).trim();
  }

  // -- remove leading and trailing spaces
  String gradeTrimmed(String gradeString) {
    return gradeString.trim();
  }

  // -- concatenate all for list display
  String wholeGrade() {
    return unitName + ": " + ac1Grade + "| " + ac2Grade + "| " + ac3Grade + "| " + ac4Grade + "| " + ac5Grade;
  }

  String shortWholeGradeACOnly() {
    return "AC1: " +
        shortGrade(ac1Grade) +
        " AC2: " +
        shortGrade(ac2Grade) +
        " AC3: " +
        shortGrade(ac3Grade) +
        " AC4: " +
        shortGrade(ac4Grade) +
        " AC5: " +
        shortGrade(ac5Grade);
  }

  // -- Function to calculate points earned from a unit grade set
  int gradePoints(String unitName, String gradeString) {
    gradeString = gradeString.trim();
    String exceptionUnit = 'B2 Industry Response';
    int tempPoints = 0;

    String gradeStringLetter = gradeLetter(gradeString);

    switch (gradeStringLetter) {
      case "P":
        {
          unitName != exceptionUnit ? tempPoints += 1 : tempPoints += 3;
        }
        break;
      case "M":
        {
          unitName != exceptionUnit ? tempPoints += 2 : tempPoints += 6;
        }
        break;
      case "D":
        {
          unitName != exceptionUnit ? tempPoints += 3 : tempPoints += 9;
        }
        break;
      default:
        tempPoints += 0;
        break;
    }

    return tempPoints;
  }

  UnitGrade defaultGrade(String unitId, String unitTitle) {
    var tempGrade = UnitGrade();
    tempGrade.unitId = unitId;
    tempGrade.unitName = unitTitle;
    tempGrade.ac1Grade = 'PD Initial default';
    tempGrade.ac2Grade = 'PD Initial default';
    tempGrade.ac3Grade = 'PD Initial default';
    tempGrade.ac4Grade = 'PD Initial default';
    tempGrade.ac5Grade = 'PD Initial default';

    return tempGrade;
  }

  String defaultGradeAsJson(UnitGrade grade) {
    return jsonEncode(grade);
  }
}
