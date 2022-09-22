import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotoapp/models/taskmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
CollectionReference<TaskModel> gettaskfromfirestore(){
  return FirebaseFirestore.instance.collection('task').withConverter<TaskModel>(
fromFirestore: (snapshot,op){
return TaskModel.fromjoison(snapshot.data()!);
},
toFirestore: (task,op)=>task.tojoison());
}

Future<void> addtaskfromfirebase(TaskModel task){//added to fire base
 var typecollection=gettaskfromfirestore();
 var doc=typecollection.doc();
 task.id=doc.id;//outo id
 return doc.set(task);

}
Future<QuerySnapshot<TaskModel>> getTaskFromFireBase(DateTime datetime) {
  var gettask = gettaskfromfirestore();
  return gettask.where('datetime', isEqualTo: DateUtils
      .dateOnly(datetime)
      .microsecondsSinceEpoch)
      .get();
}//not real time data base need set state to load
Stream<QuerySnapshot<TaskModel>> StreamTaskFromFireBase(DateTime datetime) {//real time database using with shat application
  var gettask = gettaskfromfirestore();
  return gettask.where('datetime', isEqualTo: DateUtils //filter tasks with time
      .dateOnly(datetime)
      .microsecondsSinceEpoch)
      .snapshots();
}
 Future<void>deleteTaskFrpmFireStore(TaskModel task){

 return gettaskfromfirestore().doc(task.id).delete();

}
Stream<QuerySnapshot<TaskModel>> deleteStreamTaskFromFireBase(DateTime datetime) {//real time database using with shat application
  var gettask = gettaskfromfirestore();
  return gettask.where('datetime', isEqualTo: DateUtils //filter tasks with time
      .dateOnly(datetime)
      .microsecondsSinceEpoch)
      .snapshots();
}
Future<void>UpdateTaskFrpmFireStore(TaskModel task){



  print('the id is${task.id}');
  return gettaskfromfirestore().doc(task.id).update(task.tojoison());

}