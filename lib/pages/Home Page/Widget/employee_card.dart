// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:crudapp/pages/Emply%20Form%20Screen/widget/emp_text_field.dart';
import 'package:crudapp/pages/Emply%20Form%20Screen/widget/save_button.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeCard extends StatefulWidget {
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
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  final imagePicker = ImagePicker();
  String imageUrl = "";
  bool isLoading = false;
  String? value;
  File? _image;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> getImage() async {
    try {
      final pickfile = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);

      if (pickfile != null) {
        setState(() {
          _image = File(pickfile.path);
        });
      } else {
        const Text("No Image Selected");
      }
    } catch (e) {
      Text("Error in picking image: $e");
    }
  }

  // Future<void> uploadImage() async {
  //   if (_image != null) {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     Reference referenceImageUpload = storage.refFromURL(widget.image);
  //     await referenceImageUpload.putFile(File(_image!.path));
  //     var url = await referenceImageUpload.getDownloadURL();
  //     imageUrl = url;
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

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
                  CachedNetworkImage(
                    imageUrl: widget.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 100,
                      width: 75,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300, shape: BoxShape.circle),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 100,
                        width: 75,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: imageProvider),
                            shape: BoxShape.circle),
                      );
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      newNameController.text = widget.name;
                      newAgeController.text = widget.age;
                      newLocationController.text = widget.location;
                      updateDialogBox(
                          context,
                          newNameController,
                          newAgeController,
                          newLocationController,
                          _image,
                          widget.image);
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
                    onTap: widget.onTap,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              Text(
                maxLines: 2,
                "Name: ${widget.name}",
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                maxLines: 1,
                "Age : ${widget.age}",
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                maxLines: 1,
                "Country : ${widget.location}",
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
      TextEditingController newLocationController,
      File? newImage,
      String image) {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
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
                // Center(
                //   child: GestureDetector(
                //     onTap: () {
                //       getImage();
                //     },
                //     child: Container(
                //       height: 75,
                //       width: 75,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(color: Colors.blue, width: 2),
                //       ),
                //       child: newImage != null
                //           ? ClipRRect(
                //               borderRadius: BorderRadius.circular(100),
                //               child: Image.file(
                //                 _image!.absolute,
                //                 fit: BoxFit.cover,
                //               ),
                //             )
                //           : ClipRRect(
                //               borderRadius: BorderRadius.circular(100),
                //               child: Image.network(
                //                 image,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //     ),
                //   ),
                // ),
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
                  imageUrl: imageUrl,
                  docId: widget.docId,
                  nameController: newNameController,
                  ageController: newAgeController,
                  locationController: newLocationController,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
