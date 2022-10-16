import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/colud_firebase_helper.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  final GlobalKey<FormState> insertForKey = GlobalKey<FormState>();
  TextEditingController roleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String role = '0';
  String name = '0';
  String note = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text("Author Registration App"),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.redAccent,onPressed: () {
        dailog(context);
      }, child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: CloudFireStoreHelper.cloudFireStoreHelper.fetchData(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data!;
                    List<QueryDocumentSnapshot> queryDocumentSnapshot =
                        querySnapshot.docs;
                    return ListView.builder(
                      itemCount: queryDocumentSnapshot.length,
                      itemBuilder: (context, i) {
                        Map<String, dynamic> data =
                        queryDocumentSnapshot[i].data() as Map<String, dynamic>;

                        return Container(
                          margin: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.black12)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.menu_book,size: 80,color: Colors.grey,),
SizedBox(width: 10,),
                                    Text(
                                      "Author Name:\n${data['name']}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          CloudFireStoreHelper
                                              .cloudFireStoreHelper
                                              .deleteData(
                                              id: queryDocumentSnapshot[i].id);
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
                                  color: Colors.black,
                                ),
                                Center(
                                  child: Text(
                                    "Books Name",
                                    style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "${data['books']}",
                                  style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  dailog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Center(
              child: Text("Author Details"),
            ),
            content: Form(
              key: insertForKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextFormField(
                  //   controller: roleController,
                  //   onSaved: (val) {
                  //     setState(() {
                  //       role = val!;
                  //     });
                  //   },
                  //   // onChanged: (),
                  //   decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       //hintText: 'Note no',
                  //       labelText: 'NO.'),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
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
                        hintText: 'Enter Author name',
                        labelText: 'name'),
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
                        hintText: 'Enter Books name',
                        labelText: 'Books'),
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
                    CloudFireStoreHelper.cloudFireStoreHelper.insertData(
                        name: nameController.text, books: note, );
                    setState(() {
                      //displayData = DBHelper.dbHelper.fetchAllData();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Record of $name insert succecs")));
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
