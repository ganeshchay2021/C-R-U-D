import 'package:crudapp/pages/Emply%20Form%20Screen/ui/employee_form_screen.dart';
import 'package:flutter/material.dart';

class FloatingActBtn extends StatelessWidget {
  const FloatingActBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue.shade300,
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const EmployeeFormScreen();
          },
        ));
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
