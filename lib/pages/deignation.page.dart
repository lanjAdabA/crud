import 'package:auto_route/auto_route.dart';
import 'package:crud/models/designation.dart';
import 'package:crud/serviceAPI.dart';
import 'package:flutter/material.dart';

class DesignationPage extends StatefulWidget {
  const DesignationPage({super.key});

  @override
  State<DesignationPage> createState() => _DesignationPageState();
}

class _DesignationPageState extends State<DesignationPage> {
  List<Designation> newDesignationList = [];

  final TextEditingController designationfieldcontroller =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    final designationData = await ServiceApi().get_designation();

    setState(() {
      newDesignationList = designationData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[100],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await createNewDepartmentDialogue(context);
          },
          label: const Text("Create New Designation"),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.red[500],
        ),
        appBar: AppBar(
          backgroundColor: Colors.red[400],
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
                  Colors.purple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: const Text(
              '[CRUD Operation (Designation)]',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: newDesignationList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: index.isEven ? Colors.red[200] : Colors.red[300],
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
                                  Icons.local_fire_department_outlined,
                                  color:
                                      index.isEven ? Colors.red : Colors.amber,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Designation Name:   ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: newDesignationList[index].name,
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
                                          text: newDesignationList[index]
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
                                  onTap: () {},
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
                          color: Colors.red[100],
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
                    controller: designationfieldcontroller,
                    decoration:
                        const InputDecoration.collapsed(hintText: 'CLICK HERE'),
                  ),
                ),
                title: const Text(
                  "Add new Designation ! ",
                  style: TextStyle(fontSize: 22),
                ),
                icon: const Icon(Icons.addchart_outlined),
                backgroundColor: Colors.red[100],
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {
                        context.router.pop();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                      label: const Text("cancel")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        await ServiceApi()
                            .create_designation(
                                designationName:
                                    designationfieldcontroller.text)
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
