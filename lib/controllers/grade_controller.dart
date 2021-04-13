import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GradeController extends GetxController {
  final storage = GetStorage();

  var a1Grade = ''.obs;
  var a2Grade = ''.obs;
  var b1Grade = ''.obs;
  var b2Grade = ''.obs;

  @override
  void onInit() {
    a1Grade.value = storage.read('a1Grade') ?? '';
    a2Grade.value = storage.read('a2Grade') ?? '';
    b1Grade.value = storage.read('b1Grade') ?? '';
    b2Grade.value = storage.read('b2Grade') ?? '';
    super.onInit();
  }

  // -- Methods for update
  void updateA1(String newGrade) {
    a1Grade.value = newGrade;
    update();
  }

  void updateA2(String newGrade) {
    a2Grade.value = newGrade;
    update();
  }

  void updateB1(String newGrade) {
    b1Grade.value = newGrade;
    update();
  }

  void updateB2(String newGrade) {
    b2Grade.value = newGrade;
    update();
  }
}
