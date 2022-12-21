import 'package:auto_route/auto_route.dart';
import 'package:crud/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NavigateToPages extends StatelessWidget {
  const NavigateToPages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
//? navigate to department list
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(
            height: 50,
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.blue[700],
                elevation: 10,
                backgroundColor: Colors.grey[700]),
            icon: const Icon(Icons.business_rounded),
            onPressed: () {
              context.router.push(const DepartmentRoute());
              EasyLoading.showToast("Showing Department List");
            },
            label: const Text("View Department List"),
          ),
        ),
//? navigate to designation List
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(
            height: 50,
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.red,
                elevation: 10,
                backgroundColor: Colors.grey[700]),
            icon: const Icon(Icons.badge_outlined),
            onPressed: () {
              context.router.push(const DesignationRoute());
              EasyLoading.showToast(" Showing Designation List");
            },
            label: const Text("View Designation List"),
          ),
        ),
      ],
    );
  }
}
