// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:crudapp/Service/firebase_service.dart';
import 'package:crudapp/pages/Emply%20Form%20Screen/widget/emp_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:crudapp/pages/Home%20Page/Widget/my_appbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  File? _image;
  final imagePicker = ImagePicker();
  String imageUrl = "";
  bool isLoading = false;
  String? value;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> getImage() async {
    try {
      final pickfile = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      setState(() {
        if (pickfile != null) {
          _image = File(pickfile.path);
        } else {
          const Text("No Image Selected");
        }
      });
    } catch (e) {
      Text("Error in picking image: $e");
    }
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      setState(() {
        isLoading = true;
      });
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          storage.ref().child("empImages/").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(_image!);
      var url = await (await task).ref.getDownloadURL();
      imageUrl = url;
      setState(() {
        isLoading = false;
      });
    } else {
      imageUrl =
          "https://images.rawpixel.com/image_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTExXzMuanBn.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: myAppBar(
        "Employee",
        " Form",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _image!.absolute,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.camera),
                  ),
                ),
              ),
        
              const SizedBox(
                height: 10,
              ),
              //Textfield of Name
              EmpTextField(
                controller: nameController,
                text: "Name",
                isNumKey: false,
              ),
        
              const SizedBox(
                height: 10,
              ),
              //Textfield of age
              EmpTextField(
                controller: ageController,
                text: "Age",
                isNumKey: true,
              ),
        
              const SizedBox(
                height: 10,
              ),
        
              //Textfield of Country
              EmpTextField(
                controller: locationController,
                isNumKey: false,
                text: "Location",
              ),
        
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                    ),
                    onPressed: () async {
                      await uploadImage();
                      if (nameController.text.isEmpty ||
                          ageController.text.isEmpty ||
                          locationController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.red,
                            content: Text(
                              "Some Field are empty",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        String age = ageController.text.toString();
                        firebaseService
                            .addEmpDetails(
                              nameController.text,
                              age,
                              locationController.text,
                              imageUrl,
                            )
                            .then((value) => Fluttertoast.showToast(
                                  msg: "Details Added Successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM_RIGHT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16,
                                ));
                        Navigator.pop(context);
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : const Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
