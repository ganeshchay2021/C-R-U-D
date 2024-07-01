// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:crudapp/pages/Emply%20Form%20Screen/widget/emp_text_field.dart';
import 'package:crudapp/pages/Emply%20Form%20Screen/widget/save_button.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String age;
  final String image;
  final String location;
  final VoidCallback onTap;
  final String docId;
  const EmployeeCard({
    super.key,
    required this.name,
    required this.age,
    required this.image,
    required this.location,
    required this.onTap,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController newNameController = TextEditingController();
    final TextEditingController newAgeController = TextEditingController();
    final TextEditingController newLocationController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 5.0,
        child: Container(
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  const Spacer(), 
                  GestureDetector(
                    onTap: () {
                      newNameController.text = name;
                      newAgeController.text = age;
                      newLocationController.text = location;
                      updateDialogBox(
                        context,
                        newNameController,
                        newAgeController,
                        newLocationController,
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              Text(
                maxLines: 2,
                "Name: $name",
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                maxLines: 1,
                "Age : $age",
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                maxLines: 1,
                "Country : $location",
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> updateDialogBox(
      BuildContext context,
      TextEditingController newNameController,
      TextEditingController newAgeController,
      TextEditingController newLocationController) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          title: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 19,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: "Edit"),
                TextSpan(
                  text: " Details",
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EmpTextField(
                controller: newNameController,
                text: "Name",
                isNumKey: false,
              ),
              const SizedBox(
                height: 5,
              ),
              EmpTextField(
                controller: newAgeController,
                text: "Age",
                isNumKey: true,
              ),
              const SizedBox(
                height: 5,
              ),
              EmpTextField(
                controller: newLocationController,
                text: "Location",
                isNumKey: false,
              ),
              const SizedBox(
                height: 15,
              ),
              SaveButton(
                  docId: docId,
                  nameController: newNameController,
                  ageController: newAgeController,
                  locationController: newLocationController)
            ],
          ),
        );
      },
    );
  }
}
