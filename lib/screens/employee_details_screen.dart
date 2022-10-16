import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:task_three/services/models/employee_model.dart';
import 'package:task_three/utils/widgets/back_arrow_button_widget.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final EmployeeDetails employeeInfo;
  const EmployeeDetailsScreen({super.key, required this.employeeInfo});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Employee Details'),
            leading: BackArrowButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: SafeArea(
            child: KeyboardDismissOnTap(
          child: employeeDetailsScreenUI(),
        )));
  }

  Widget employeeDetailsScreenUI() {
    return Center(
        child: Container(
            //    color: Colors.grey,
            padding: const EdgeInsets.only(
                top: 100, bottom: 100, left: 10, right: 10),
            child: cardUI()));
  }

  Widget cardUI() {
    return Card(
        color: Colors.grey,
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              widget.employeeInfo.profileImage,
              fit: BoxFit.fill,
            ),
          ),
          sizedBoxUI(10),
          ListTile(
            title: Text(
              widget.employeeInfo.name,
              style: themeData.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxUI(20),
                employeeInfoRow(Icons.mail, widget.employeeInfo.email),
                employeeInfoRow(Icons.phone, widget.employeeInfo.phone),
                employeeInfoRow(Icons.web, widget.employeeInfo.website),
              ],
            ),
          ),
        ]));
  }

  Widget sizedBoxUI(double? height) {
    return SizedBox(
      height: height,
    );
  }

  Widget employeeInfoRow(IconData icon, String text) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(text,
              style: themeData.textTheme.subtitle1, textAlign: TextAlign.center)
        ]);
  }
}
