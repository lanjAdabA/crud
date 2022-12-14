import 'package:crud/models/department.dart';
import 'package:crud/serviceAPI.dart';
import 'package:flutter/material.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<Department> newDepartmentList = [];

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
        backgroundColor: Colors.blueAccent[100],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await CreateNewDepartmentDialogue(context);
          },
          label: const Text("Create New Department"),
          icon: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[200],
          leading: const Icon(Icons.apple_sharp),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    // getData();
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
          child: Padding(
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
                      color: index.isEven ? Colors.blue[300] : Colors.blue[200],
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
                                  Icons.ac_unit_rounded,
                                  color: index.isEven
                                      ? Colors.blue[100]
                                      : Colors.blue[400],
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Department Name:   ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: newDepartmentList[index].name,
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
                                    style: DefaultTextStyle.of(context).style,
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
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    PopupMenuButton;
                                  },
                                  child: const Icon(
                                    Icons.more_horiz,
                                    size: 50,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.blueAccent[100],
                          thickness: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  CreateNewDepartmentDialogue(BuildContext context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return const AlertDialog();
            },
          );
        });
  }
}
