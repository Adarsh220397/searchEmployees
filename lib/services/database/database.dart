import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_three/services/database/sqlite_db.dart';
import 'package:task_three/services/models/employee_model.dart';

class DataBase {
  DataBase._internal();
  static DataBase instance = DataBase._internal();

  Future<List<EmployeeDetails>> getProductList() async {
    var response = await http.get(Uri.parse(
      'http://www.mocky.io/v2/5d565297300000680030a986',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<EmployeeDetails> employeeDetailslist =
          jsonResponse.map((job) => EmployeeDetails.fromJson(job)).toList();

      return employeeDetailslist;
    } else {
      throw Exception('Failed to get the data');
    }
  }

  Future<void> insertData(List<EmployeeDetails> employeeDetailslist) async {
    // List<EmployeeDetails> list = await getProductList();

    for (EmployeeDetails employeeDetails in employeeDetailslist) {
      await DatabaseHelper.instance.insert(employeeDetails);
    }
  }

  Future<List<EmployeeDetails>> getData() async {
    List<EmployeeDetails> list = [];
    try {
      list = await DatabaseHelper.instance.queryEmployeeList();
    } catch (e) {
      print('-error ---$e');
    }

    return list;
  }
}
