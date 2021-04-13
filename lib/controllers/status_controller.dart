import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  var storage = GetStorage();

  var status = ''.obs;

  @override
  void onInit() {
    status.value = storage.read('registered') ?? 'unregistered';
    // TODO : Remove debug print method
    print(
      status.value.toString(),
    );
    super.onInit();
  }

  void updateStatus(String newStatus) {
    status.value = newStatus;
    update();
  }
}
