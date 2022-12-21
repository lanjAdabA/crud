// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:crud/widgets/locationService.dart';
import 'package:crud/widgets/navigateToPages.dart';
import 'package:crud/widgets/uploadImage.dart';
import 'package:auto_route/auto_route.dart';
import 'package:crud/router/router.gr.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:crud/models/department.dart';
import 'package:crud/models/designation.dart';
import 'package:crud/models/employee.dart';
import 'package:crud/serviceAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropDownDesignation;
  String? dropDownDepartment;
  String? dropDownDesignation1;
  String? dropDownDepartment1;

  final TextEditingController namefieldcontroller = TextEditingController();
  final TextEditingController designationfieldcontroller =
      TextEditingController();
  final TextEditingController departmentfieldcontroller =
      TextEditingController();
  String dateTime = "";
  String dateTime2 = "";
  String dateTime3 = "";
  String dateTime4 = "";

  List<Employee> newEmployeeList = [];
  List<Designation> newDesignationList = [];
  List<Department> newDepartmentList = [];

  var format = DateFormat("dd-MM-yyyy");

  List<String> allDesId = [];
  List<String> allDepId = [];
  List<String> allDesName = [];
  List<String> allDepName = [];

  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  DateTime? start = DateTime.now();
  DateTime? end = DateTime.now();

  String profileImage = "";
  final location = "";

  Widget _dataofbirth(String dob) {
    return DateTimeField(
      controller: TextEditingController(text: dob),
      decoration: const InputDecoration(
        labelText: ' Select Date of Birth',
      ),
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
                helpText: "SELECT DATE OF BIRTH",
                cancelText: "CANCEL",
                confirmText: "OK",
                fieldHintText: "DATE/MONTH/YEAR",
                fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                errorFormatText: "Enter a Valid Date",
                errorInvalidText: "Date Out of Range")
            .then((value) async {
          final prefs = await SharedPreferences.getInstance();
          String image = prefs.getString("profileImage")!;
          setState(() {
            profileImage = image;

            dateTime = "${value!.year}-${value.month}-${value.day}";
            dateTime2 = "${value.year}-${value.month}-${value.day}";
          });

          log(profileImage);
          return value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    final employeeData = await ServiceApi().get_employee();
    final designationData = await ServiceApi().get_designation();
    final departmentData = await ServiceApi().get_department();

    setState(() {
      newEmployeeList = employeeData!;
      newDepartmentList = departmentData!;
      newDesignationList = designationData!;
    });
    for (var element in newDesignationList) {
      allDesId.add(element.id.toString());
    }
    for (var element in newDepartmentList) {
      allDepId.add(element.id.toString());
    }
    for (var element in newDesignationList) {
      allDesName.add(element.name.toString());
    }
    for (var element in newDepartmentList) {
      allDepName.add(element.name.toString());
    }
    log(allDepName.toString());
    log(allDesName.toString());
  }

  Future getData2() async {
    final employeeData = await ServiceApi().get_employee();
    final designationData = await ServiceApi().get_designation();
    final departmentData = await ServiceApi().get_department();

    setState(() {
      newEmployeeList = employeeData!;
      newDepartmentList = departmentData!;
      newDesignationList = designationData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await createNewEmployeeDialogue(context);
        },
        label: const Text("Create New Employee"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      appBar: AppBar(
        leading: GestureDetector(
            onLongPress: () async {
              final prefs = await SharedPreferences.getInstance();
              log("logout");
              prefs.remove("token").whenComplete(
                  () => context.router.push(const AuthFlowRoute()));
            },
            child: const Icon(Icons.apple_sharp)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
                onTap: () {
                  getData2();
                },
                child: Column(
                  children: const [
                    Icon(Icons.refresh),
                    Text("refresh screen"),
                  ],
                )),
          ),
        ],
        title: const Text("[CRUD operation(Employee)]"),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newEmployeeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final data = newEmployeeList[index];

                    int desindex = allDesId.indexOf(
                        newEmployeeList[index].designationId.toString());

                    int depind = allDepId.indexOf(
                        newEmployeeList[index].departmentId.toString());
//? listTileBlock
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color:
                                index.isEven ? Colors.white : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Employee Details",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    padding: const EdgeInsets.only(right: 20),
                                    onPressed: () {
                                      log("pressed menu button more");
//? menu option button for update n delete
                                      showMenu(
                                        context: context,
                                        position: const RelativeRect.fromLTRB(
                                            500.0, 500.0, 140.0, 20.0),
                                        items: [
                                          //! update
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                int ind1 = allDesId.indexOf(
                                                    newEmployeeList[index]
                                                        .designationId
                                                        .toString());
                                                int ind2 = allDepId.indexOf(
                                                    newEmployeeList[index]
                                                        .departmentId
                                                        .toString());

                                                setState(() {
                                                  namefieldcontroller.text =
                                                      newEmployeeList[index]
                                                          .name;

                                                  dropDownDesignation =
                                                      allDesName[ind1];

                                                  dropDownDepartment =
                                                      allDepName[ind2];

                                                  dropDownDesignation1 =
                                                      newEmployeeList[index]
                                                          .designationId
                                                          .toString();

                                                  dropDownDepartment1 =
                                                      newEmployeeList[index]
                                                          .departmentId
                                                          .toString();

                                                  dateTime2 =
                                                      "${newEmployeeList[index].dateOfBirth.day}-${newEmployeeList[index].dateOfBirth.month}-${newEmployeeList[index].dateOfBirth.year}";
                                                  dateTime4 =
                                                      "${newEmployeeList[index].dateOfBirth.year}-${newEmployeeList[index].dateOfBirth.month}-${newEmployeeList[index].dateOfBirth.day}";
                                                });
                                                Navigator.pop(context);

                                                updateEmployeeDetailShowDidalog(
                                                    context, index);
                                              },
                                              child: const ListTile(
                                                  title: Text("Update"),
                                                  leading: Icon(Icons.sync)),
                                            ),
                                          ),

                                          //! delete
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      elevation: 3,
                                                      title: const Text(
                                                          "Are you sure you want to delete this Employee data"),
                                                      actions: [
                                                        ElevatedButton.icon(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .check_circle_outlined,
                                                            ),
                                                            label: const Text(
                                                                "cancel")),
                                                        const SizedBox(
                                                            width: 30),
                                                        ElevatedButton.icon(
                                                            onPressed: () {
                                                              ServiceApi()
                                                                  .delete_employee(
                                                                      id: newEmployeeList[
                                                                              index]
                                                                          .id
                                                                          .toString())
                                                                  .whenComplete(
                                                                      () {
                                                                getData();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .check_circle_outlined,
                                                            ),
                                                            label: const Text(
                                                                "confirm"))
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const ListTile(
                                                  title: Text("Remove"),
                                                  leading: Icon(
                                                      Icons.delete_outline)),
                                            ),
                                          ),
                                        ],
                                        elevation: 8.0,
                                      );
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          shape: BoxShape.circle,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 2,
                                                blurRadius: 2)
                                          ]),
                                      child: const Icon(
                                        Icons.more_horiz,
                                        size: 25,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Employee Name:   ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: newEmployeeList[index].name,
                                              style: const TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Employee Id:   ',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: newEmployeeList[index]
                                                        .id
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepPurple,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Department Id :',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: allDepId[depind]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepPurple,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
//? dpt name
                                        text: 'Designation :  ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: allDesName[desindex]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.deepPurple,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Department Name : ',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: allDepName[depind]
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Location : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: newEmployeeList[index]
                                                  .geoLocation,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ClipOval(
                                    child: Image.network(
                                        height: 120,
                                        "http://phpstack-598410-2859373.cloudwaysapps.com/${newEmployeeList[index].image}")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 12,
            ),
            const NavigateToPages(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> updateEmployeeDetailShowDidalog(
      BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (cnt) {
        return StatefulBuilder(builder:
            ((BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.red,
                          elevation: 5,
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {
                        Navigator.pop(context);

                        setState(() {
                          namefieldcontroller.clear();
                          dropDownDesignation = null;
                          dropDownDepartment = null;
                          dateTime2 = "";
                        });
                      },
                      label: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const Icon(Icons.cancel),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blue,
                            elevation: 5,
                            backgroundColor: Colors.green),
                        onPressed: () {
                          ServiceApi()
                              .update_employee(
                                  id: newEmployeeList[index].id.toString(),
                                  name: namefieldcontroller.text,
                                  desId: dropDownDesignation1!,
                                  depId: dropDownDepartment1!,
                                  dob: dateTime4)
                              .whenComplete(() {
                            getData().then((value) => context.router.pop());
                          });
                          setState(() {
                            allDesId = [];
                            allDepId = [];
                            allDepName = [];
                            allDesName = [];
                            namefieldcontroller.clear();
                            dropDownDesignation = null;
                            dropDownDepartment = null;
                            dateTime2 = "";
                          });
                        },
                        label: const Text(
                          "Update",
                          style: TextStyle(fontSize: 20),
                        ),
                        icon: const Icon(Icons.update),
                      ),
                    )
                  ],
                ),
              ],
              title: const Text("Update Employee Details"),
              content: Form(
                child: SizedBox(
                  height: 250,
                  child: Column(
                    children: [
                      TextField(
                          keyboardType: TextInputType.text,
                          controller: namefieldcontroller,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Name',
                          )),
                      Row(
                        children: [
                          const Text('Designation :'),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              dropdownDirection: DropdownDirection.left,
                              dropdownWidth: 200,
                              hint: const Text('Select'),
                              value: dropDownDesignation,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: allDesName.map((String items) {
                                log(items);
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.toString()),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownDesignation = newValue!;
                                });
                                int ind =
                                    allDesName.indexOf(dropDownDesignation!);
                                dropDownDesignation1 = allDesId[ind];
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Department :"),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              dropdownDirection: DropdownDirection.left,
                              dropdownWidth: 200,
                              hint: const Text('Select'),
                              value: dropDownDepartment,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: allDepName.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownDepartment = newValue!;
                                });
                                int ind =
                                    allDepName.indexOf(dropDownDepartment!);
                                dropDownDepartment1 = allDepId[ind];
                              },
                            ),
                          ),
                        ],
                      ),
                      _dataofbirth(dateTime2),
                    ],
                  ),
                ),
              ));
        }));
      },
    );
  }

  createNewEmployeeDialogue(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text(
                "Add new Employee details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //*upload avatar
                    const UploadImage(),
                    //*namefield

                    TextField(
                      keyboardType: TextInputType.text,
                      controller: namefieldcontroller,
                      decoration: const InputDecoration(
                          // decoration: const InputDecoration.collapsed(
                          // for hidden underline

                          hintText: 'Enter Employee Name:'),
                    ),

                    //* designstion field

                    Row(
                      children: [
                        const Text("Select Designation : "),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            dropdownDirection: DropdownDirection.left,
                            dropdownWidth: 200,
                            hint: const Text('Choose'),
                            value: dropDownDesignation,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: allDesName.map((String items) {
                              log(items);
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownDesignation = newValue as String;
                              });
                              int indexOfDeg =
                                  allDesName.indexOf(dropDownDesignation!);
                              dropDownDesignation1 = allDesId[indexOfDeg];
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Select Department :  "),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            dropdownDirection: DropdownDirection.left,
                            dropdownWidth: 200,
                            hint: const Text(' Choose'),
                            value: dropDownDepartment,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: allDepName.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                dropDownDepartment = newValue!;
                              });
                              int indexOfDep =
                                  allDepName.indexOf(dropDownDepartment!);
                              dropDownDepartment1 = allDepId[indexOfDep];
                            },
                          ),
                        ),
                      ],
                    ),
                    _dataofbirth(dateTime2),
                    const LocationService(),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(height: 40, width: 130),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.red,
                            elevation: 5,
                            backgroundColor: Colors.grey[300]),
                        onPressed: () {
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
                      constraints:
                          const BoxConstraints.tightFor(height: 40, width: 130),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.blue,
                            elevation: 5,
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          String location = prefs.getString("finalLocation")!;

                          setState() {
                            location = location;
                          }

                          EasyLoading.show(status: 'Adding..');
                          log(location);
                          log(dropDownDepartment1.toString());
                          log(dropDownDesignation1.toString());
                          log(dateTime.toString());
                          await ServiceApi()
                              .create_employee(
                                  name: namefieldcontroller.text,
                                  desId: dropDownDesignation1.toString(),
                                  depId: dropDownDepartment1.toString(),
                                  dob: dateTime.toString(),
                                  image: profileImage,
                                  location: location)
                              .whenComplete(() {
                            EasyLoading.dismiss();

                            Navigator.of(ctx).pop(context);
                            getData2();
                          });
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
  }
}
