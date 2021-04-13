import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../components/dropdown_control.dart';
import '../components/dropdown_wrapper.dart';
import '../controllers/status_controller.dart';
import '../models/user.dart';
import '../uidata/course_data.dart';
import '../utils/status_manager.dart';
import '../utils/user_manager.dart';

class PageSettings extends StatefulWidget {
  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  var storage = GetStorage();
  User _user = User();

  StatusManager statusManager = StatusManager();
  UserManager userManager = UserManager();

  String _username;
  String _passcode;
  String _chosenCourse;
  String _chosenProfile;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();

  StatusController statusController = Get.find<StatusController>();

  // TODO: Populate controls with stored data if available
  @override
  void setState(fn) {
    usernameController.text = storage.read('username').toString() ?? '';
    _username = storage.read('username').toString() ?? '';
    passcodeController.text = storage.read('passcode').toString() ?? '';
    _chosenCourse = storage.read('course').toString() ?? '';
    _chosenProfile = storage.read('target').toString() ?? '';

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'SETTINGS',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              color: Theme.of(context).primaryColor,
              tooltip: 'Check data',
              onPressed: () {
                Get.toNamed('/testbed');
              }),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                // -- header text
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter your profile data',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // -- username control
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter a Username',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30.0,
                    ),
                  ),
                  obscureText: false,
                ),
              ),
              // -- Passcode control
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: passcodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter a Passcode',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30.0,
                    ),
                  ),
                  obscureText: false,
                ),
              ),

              buildCourseDropdown(),
              buildProfileDropdown(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: GestureDetector(
                  onTap: () {
                    this._user.username = usernameController.text ?? 'not set';
                    this._user.passcode = passcodeController.text ?? 'not set';
                    this._user.course = _chosenCourse ?? 'not set';
                    this._user.targetProfile = _chosenProfile ?? 'not set';

                    // -- DEBUG prints
                    print('Username at Gui is ${_user.username}');
                    print('Username at Gui is ${_user.passcode}');
                    print('Username at Gui is ${_user.course}');
                    print('Username at Gui is ${_user.targetProfile}');

                    statusManager.storeStatus('registered');
                    userManager.storeUser(this._user);

                    Get.snackbar(
                      'Status',
                      'Status set to ${statusController.status.toString()}',
                      backgroundColor: Colors.green,
                      colorText: Colors.black,
                    );

                    Get.toNamed('/testbed');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    alignment: Alignment.center,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      'Submit Profile Data',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    alignment: Alignment.center,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      'Reset profile data',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
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
