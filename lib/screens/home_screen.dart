import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:task_three/screens/employee_details_screen.dart';
import 'package:task_three/services/database/database.dart';
import 'package:task_three/services/models/employee_model.dart';
import 'package:task_three/utils/widgets/circular_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;

  bool isLoading = false;
  List<EmployeeDetails> filterList = [];
  List<EmployeeDetails> suggestionList = [];

  TextEditingController searchDistributorController = TextEditingController();
  FocusNode searchDistributorFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // call db
    getData();
  }

  getData() async {
    isLoading = true;
    // filterList = await DataBase.instance.getProductList();

    // await DataBase.instance.insertData(filterList);
    filterList = await DataBase.instance.getData();

    suggestionList = filterList;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return isLoading
        ? const CircularIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Task 3'),
            ),
            body: SafeArea(
                child: KeyboardDismissOnTap(
              child: homeScreenUI(),
            )));
  }

  Widget homeScreenUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Employee List',
            style: themeData.textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          searchDistributorFilterTextField(),
          SingleChildScrollView(
            child: navigateCardUI(),
          )
        ],
      ),
    );
  }

  Widget navigateCardUI() {
    return Column(
      children: [
        for (EmployeeDetails employeeInfo in suggestionList)
          InkWell(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EmployeeDetailsScreen(
                          employeeInfo: employeeInfo,
                        )));
              },
              child: cardUI(employeeInfo))
      ],
    );
  }

  Widget cardUI(EmployeeDetails employeeDetails) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50,
                height: 50,
                child: employeeDetails.profileImage.isEmpty
                    ? const Text('IM')
                    : Image.network(employeeDetails.profileImage)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employeeDetails.name,
                    style: themeData.textTheme.subtitle1!,
                  ),
                  Text(
                    employeeDetails.email,
                    style: themeData.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }

  Widget searchDistributorFilterTextField() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ListTile(
        tileColor: Colors.grey,
        leading: const Icon(Icons.search),
        title: TextFormField(
          focusNode: searchDistributorFocusNode,
          controller: searchDistributorController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            filled: false,
            isDense: true,
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: "Search name/mailId here...",
          ),
          onChanged: (value) => {_runFilter(value)},
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) async {
    if (enteredKeyword.isEmpty) {
      filterList;
      setState(() {});
      return;
    }

    var suggestions = filterList.where(
      (element) {
        var name = element.name.toLowerCase();
        var email = element.email.toLowerCase();
        var input = enteredKeyword.toLowerCase();
        return name.contains(input) || email.contains(input);
      },
    ).toList();

    setState(() {
      if (enteredKeyword.isNotEmpty) {
        suggestionList = suggestions;
      }
    });
  }
}
