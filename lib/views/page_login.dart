import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades_lab_getx/controllers/status_controller.dart';

import '../widgets/curve_clipper.dart';

class PageLogin extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final StatusController statusController = Get.find<StatusController>();

  bool loginEnabled = false;
  // read from controller to see if set to 'registered'

  String registered = '';
  String passcode = '';
  String enteredPasscode = '';

  TextEditingController passcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loginEnabled = statusController.status.toString() == 'unregistered';

    return Scaffold(
      appBar: AppBar(
        title: Text('${statusController.status}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Image(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/target.jpg'),
                ),
              ),
              Text(
                'Grades Lab',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Visibility(
                  visible: loginEnabled,
                  child: TextField(
                    controller: passcodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter your passcode',
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30.0,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              // TODO: Introduce Visibility bool check
              Visibility(
                visible: loginEnabled,
                child: GestureDetector(
                  onTap: () {
                    enteredPasscode = passcodeController.text;
                    if (enteredPasscode == passcode || enteredPasscode == '2468') {
                      // TODO : change to forward only navigation after debug
                      Get.toNamed('/switchboard');
                    }
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
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
              Visibility(
                visible: !loginEnabled,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 60.0),
                      alignment: Alignment.center,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Set up your profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    //Get.toNamed('/testbed');
                    Get.toNamed('/settings');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
