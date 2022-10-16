import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/colour.dart';
import 'package:flutter/material.dart';

import '../helper/colud_firebase_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<FormState> insertForKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('counter').snapshots();

  String name = "";
  int age = 0;
  String role = "";
  String title = "";
  String note = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 25),
              child: Row(
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: mainColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.menu,
                        color: mainColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await dailog(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.amber, Colors.yellow
                    ],
                  ),
                ),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Create new",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: CloudFireStoreHelper.cloudFireStoreHelper.fetchData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data!;

                    List<QueryDocumentSnapshot> queryDocumentSnapshot =
                        querySnapshot.docs;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: queryDocumentSnapshot.length,
                        itemBuilder: (context, i) {
                          Map<String, dynamic> data = queryDocumentSnapshot[i]
                              .data() as Map<String, dynamic>;

                          // return Card(
                          //   elevation: 3,
                          //   margin: EdgeInsets.all(8),
                          //   child: ListTile(
                          //     //leading: Text(queryDocumentSnapshot[i].id),
                          //     title: Text("${data['title']}"),
                          //
                          //     subtitle: Text("${data['note']}"),
                          //   ),
                          // );
                          return Container(
                            margin: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5, color: Colors.black12)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${queryDocumentSnapshot[i].id} : ${data['title']}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            CloudFireStoreHelper
                                                .cloudFireStoreHelper
                                                .deleteData(
                                                    id: queryDocumentSnapshot[i]
                                                        .id);
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                  const Divider(
                                    height: 15,
                                    thickness: 2,
                                  ),
                                  Text(
                                    "${data['note']},",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dailog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Insert note"),
        ),
        content: Form(
          key: insertForKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: roleController,
                onSaved: (val) {
                  setState(() {
                    role = val!;
                  });
                },
                // onChanged: (),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //hintText: 'Note no',
                    labelText: 'NO.'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                onSaved: (val) {
                  setState(() {
                    name = val!;
                  });
                },
                // onChanged: (),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter note title',
                    labelText: 'title'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                controller: ageController,
                onSaved: (val) {
                  setState(() {
                    note = val!;
                  });
                },
                // onChanged: (),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter note',
                    labelText: 'Note'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (insertForKey.currentState!.validate()) {
                insertForKey.currentState!.save();

                // int res = await DBHelper.dbHelper
                //     .insertData(name: name, age: age, role: role);
                // CloudFireStoreHelper.cloudFireStoreHelper.insertData(
                //     title: nameController.text, notes: note, id: role);
                setState(() {
                  //displayData = DBHelper.dbHelper.fetchAllData();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Record of $name insertd succecs")));
              }

              Navigator.of(context).pop();
              nameController.clear();
              ageController.clear();
              roleController.clear();
            },
            child: const Text("save"),
          ),
        ],
      ),
    );
  }
}
