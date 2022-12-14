import 'package:auto_route/auto_route.dart';
import 'package:crud/models/department.dart';
import 'package:crud/router/router.gr.dart';
import 'package:crud/serviceAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<Department> newDepartmentList = [];

  final TextEditingController departmentfieldcontroller =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    final departmentData = await ServiceApi().get_department();

    setState(() {
      newDepartmentList = departmentData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await createNewDepartmentDialogue(context);
          },
          label: const Text("Create New Department"),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue[500],
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          leading: const Icon(Icons.apple_sharp),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    getData();
                    {}
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.refresh),
                      Text("refresh screen"),
                    ],
                  )),
            ),
          ],
          title: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const RadialGradient(
                center: Alignment.topLeft,
                radius: 7.0,
                colors: <Color>[
                  Color.fromARGB(255, 255, 0, 0),
                  Color.fromARGB(255, 200, 0, 0),
                  Color.fromARGB(255, 150, 0, 0),
                  Color.fromARGB(255, 70, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: const Text(
              '[CRUD Operation (Department)]',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newDepartmentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: index.isEven
                              ? Colors.blue[200]
                              : Colors.blue[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.ac_unit,
                                      color: index.isEven
                                          ? Colors.blue
                                          : Colors.blue[100],
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Department Name:   ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  newDepartmentList[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Department Id:   ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: newDepartmentList[index]
                                                  .id
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        // row with 2 children
                                        child: Row(
                                          children: const [
                                            Icon(Icons.edit),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Update",
                                            )
                                          ],
                                        ),
                                      ),
                                      // PopupMenuItem 2
                                      PopupMenuItem(
                                        value: 2,
                                        // row with two children
                                        child: Row(
                                          children: const [
                                            Icon(Icons.delete),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Delete",
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      // if value 1 show dialog
                                      if (value == 1) {
                                        setState(() {
                                          departmentfieldcontroller.text =
                                              newDepartmentList[index].name;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (cnt) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                                return AlertDialog(
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  shadowColor:
                                                                      Colors
                                                                          .blue,
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          300]),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          label: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          icon: const Icon(
                                                              Icons.cancel),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: ElevatedButton
                                                              .icon(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    shadowColor:
                                                                        Colors
                                                                            .blue,
                                                                    elevation:
                                                                        5,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green),
                                                            onPressed: () {
                                                              ServiceApi()
                                                                  .update_department(
                                                                      id: newDepartmentList[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      departmentName:
                                                                          departmentfieldcontroller
                                                                              .text)
                                                                  .whenComplete(
                                                                      () {
                                                                context.router
                                                                    .pop();
                                                                getData();
                                                              });
                                                            },
                                                            label: const Text(
                                                              "Update",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            icon: const Icon(
                                                                Icons.update),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                  title: const Text(
                                                      "Update Department"),
                                                  content: Form(
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              controller:
                                                                  departmentfieldcontroller,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Name',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                        // if value 2 show dialog
                                      } else if (value == 2) {
                                        showDialog(
                                            context: context,
                                            builder: ((BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  ((context, setState) {
                                                return AlertDialog(
                                                  title: const Text('Confirm'),
                                                  content: const Text(
                                                      'Are You Sure To Delete?'),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
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
                                                              Icons.cancel,
                                                            ),
                                                            label: const Text(
                                                                "cancel")),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: ElevatedButton
                                                                .icon(
                                                                    onPressed:
                                                                        () {
                                                                      ServiceApi().delete_department(
                                                                          id: newDepartmentList[index]
                                                                              .id
                                                                              .toString());
                                                                      getData()
                                                                          .whenComplete(
                                                                              () {
                                                                        context
                                                                            .router
                                                                            .pop();
                                                                      });
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                    ),
                                                                    label: const Text(
                                                                        "Delete")))
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }));
                                            }));
                                      }
                                    },
                                  ),
                                ])
                              ],
                            ),
                            Divider(
                              color: Colors.blue[100],
                              thickness: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
//? navigate to designation list
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 50,
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.red,
                          elevation: 10,
                          backgroundColor: Colors.blue[700]),
                      icon: const Icon(Icons.business_rounded),
                      onPressed: () {
                        context.router.push(const DesignationRoute());
                        EasyLoading.showToast("Showing designation List");
                      },
                      label: const Text("View Department List"),
                    ),
                  ),
//? navigate to employee List
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 50,
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey,
                          elevation: 10,
                          backgroundColor: Colors.blue[700]),
                      icon: const Icon(Icons.badge_outlined),
                      onPressed: () {
                        context.router.push(const AuthFlowRoute());
                        EasyLoading.showToast(" Showing Employee List");
                      },
                      label: const Text("View Employee List"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  createNewDepartmentDialogue(BuildContext context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: departmentfieldcontroller,
                    decoration:
                        const InputDecoration.collapsed(hintText: 'CLICK HERE'),
                  ),
                ),
                title: const Text(
                  "Add new Department ! ",
                  style: TextStyle(fontSize: 22),
                ),
                icon: const Icon(Icons.addchart_outlined),
                backgroundColor: Colors.blue[100],
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {
                        context.router.pop();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.blue,
                      ),
                      label: const Text("cancel")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        await ServiceApi()
                            .create_department(
                                departmentName: departmentfieldcontroller.text)
                            .whenComplete(() {
                          Navigator.of(context).pop();
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.green[300],
                      ),
                      label: const Text("Add"))
                ],
              );
            },
          );
        });
  }
}
