import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/Service/firebase_service.dart';
import 'package:crudapp/pages/Home%20Page/Widget/floating_act_btn.dart';
import 'package:crudapp/pages/Home%20Page/Widget/employee_card.dart';
import 'package:crudapp/pages/Home%20Page/Widget/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: myAppBar(
        "Flutter",
        "Firebase",
      ),
      floatingActionButton: const FloatingActBtn(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    firebaseService.deleteAllEmpDetails().then(
                          (value) => Fluttertoast.showToast(
                            msg: "All Details Erased",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM_RIGHT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 16,
                          ),
                        );
                  },
                  child: const Text(
                    "Clear All",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseService.getEmpDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List empDetails = snapshot.data!.docs;

                  //display as a list
                  return ListView.builder(
                    itemCount: empDetails.length,
                    itemBuilder: (context, index) {
                      //get each individual doc
                      DocumentSnapshot document = empDetails[index];
                      String docId = document.id;

                      //get note from each doc
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String name = data["Name"];
                      String age = data["Age"];
                      String location = data["Location"];
                      String image = data["Image"];

                      return EmployeeCard(
                        docId: docId,
                        name: name,
                        age: age,
                        image: image,
                        location: location,
                        onTap: () {
                          firebaseService.deleteEmpDetails(docId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              backgroundColor: Colors.green,
                              content: Text(
                                "Details Delete Successfully",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                  //
                } else {
                  return const Center(
                    child: Text(
                      "No any Data Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
