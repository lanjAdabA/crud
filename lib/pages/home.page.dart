import 'dart:developer';

import 'package:crud/serviceAPI.dart';
import 'package:crud/models/employee.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  final TextEditingController namefieldcontroller =TextEditingController();
  final TextEditingController designationfieldcontroller =TextEditingController();
  final TextEditingController departmentfieldcontroller =TextEditingController();
  String dateTimer="";

  var format=DateFormat("dd-MM-yyyy");
  
  List<Employee> newEmployeeList = [];

  // final DateTime _dateTime = DateTime.now();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  DateTime? start = DateTime.now();
  DateTime? end = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    final employeeData = await ServiceApi().get_employee();
    setState(() {
      newEmployeeList = employeeData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return AlertDialog(
                    title: const Text(
                      "Add new Employee details",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter Employee Name:'),
                          ),
                          const TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter Employee Id:',
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          const TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter Employee Designation:'),
                          ),
                          const TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter Department ID/Name:'),
                          ),
                          TextButton(
                              style: const ButtonStyle(),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2023),
                                );
                              },
                              child: const ListTile(
                                title: Text("Select D.O.B."),
                                leading: Icon(Icons.date_range_outlined),
                              )),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                height: 40, width: 130),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.red,
                                  elevation: 5,
                                  backgroundColor: Colors.grey[300]),
                              onPressed: () async {
                                await ServiceApi().create_employee(name: namefieldcontroller.text, desId: designationfieldcontroller.text, depId: depId, dob: dob)
                                Navigator.of(ctx).pop();
                              },
                              label: const Text(
                                "Cancel",
                                style: TextStyle(fontSize: 20),
                              ),
                              icon: const Icon(Icons.cancel),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                height: 40, width: 130),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.blue,
                                  elevation: 5,
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              label: const Text(
                                "Create",
                                style: TextStyle(fontSize: 20),
                              ),
                              icon: const Icon(Icons.add_circle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
              );
            },
          );
        },
        label: const Text("Create New Employee"),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: const Icon(Icons.apple_sharp),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
                onTap: () {
                  getData();
                },
                child: Column(
                  children: const [
                    Icon(Icons.refresh),
                    Text("refresh screen"),
                  ],
                )),
          ),
        ],
        title: const Text("CRUD operation"),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newEmployeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = newEmployeeList[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Employee Name:   ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: newEmployeeList[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Employee Id:   ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: newEmployeeList[index]
                                            .id
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Department Id:   ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: newEmployeeList[index]
                                            .departmentId
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              IconButton(
                                  padding: const EdgeInsets.only(right: 20),
                                  onPressed: () {
                                    log("pressed menu button more");

                                    showMenu(
                                      context: context,
                                      position: const RelativeRect.fromLTRB(
                                          500.0, 500.0, 140.0, 20.0),
                                      items: [
                                        const PopupMenuItem(
                                          child: ListTile(
                                              title: Text("Update"),
                                              leading: Icon(Icons.sync)),
                                        ),
                                        PopupMenuItem(
                                          child: InkWell(
                                            onTap: () {
                                              ServiceApi()
                                                  .delete_employee(
                                                      id: newEmployeeList[index]
                                                          .id
                                                          .toString())
                                                  .whenComplete(() {
                                                getData();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: const ListTile(
                                                title: Text("Remove"),
                                                leading:
                                                    Icon(Icons.delete_outline)),
                                          ),
                                        ),
                                      ],
                                      elevation: 8.0,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    size: 48,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 50,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        // shadowColor: Colors.red,
                        elevation: 5,
                        backgroundColor: Colors.grey[700]),
                    icon: const Icon(Icons.business_rounded),
                    onPressed: () {},
                    label: const Text("View Department List"),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 50,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        // shadowColor: Colors.red,
                        elevation: 5,
                        backgroundColor: Colors.grey[700]),
                    icon: const Icon(Icons.badge_outlined),
                    onPressed: () {},
                    label: const Text("View Designation List"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            )
          ],
        ),
      ),
    );
  }
}
