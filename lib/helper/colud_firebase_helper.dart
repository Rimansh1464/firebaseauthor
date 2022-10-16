import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreHelper{
  CloudFireStoreHelper._();

  static final CloudFireStoreHelper cloudFireStoreHelper = CloudFireStoreHelper._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference employee = FirebaseFirestore.instance.collection('employee');
  CollectionReference note = FirebaseFirestore.instance.collection('note');
  CollectionReference Author = FirebaseFirestore.instance.collection('Author');
 // CollectionReference Counter = FirebaseFirestore.instance.collection('counter');

  //TODO : insertData
  insertData({required String name,required String books})async{
    // await note.doc(id).set({'title' :title,'note': notes});
    await Author.doc().set({'name' :name,'books': books});

  }
  //TODO : fetchData
  Stream<QuerySnapshot> fetchData(){
      Stream<QuerySnapshot> stream = Author.snapshots();
      // Stream<QuerySnapshot> stream = note.snapshots();
      //Stream<QuerySnapshot> Counterstream = Counter.snapshots();
      return stream;
   }
//TODO : deleteData
  deleteData({required id })async{
    await Author.doc(id).delete();
    // await note.doc(id).delete();

  }
}