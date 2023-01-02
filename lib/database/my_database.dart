import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/tasks_model.dart';
import 'package:todo_app/ui/utils/date_utils.dart';

CollectionReference<TaskData> getTaskCollection() {
  return FirebaseFirestore.instance.collection('tasks').withConverter<TaskData>(
        fromFirestore: (snapshot, options) =>
            TaskData.fromFirestore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
      );
}

Future<void> addTaskToFirebaseFirestore(TaskData taskData) {
  var collection = getTaskCollection();
  var docRef = collection.doc();
  taskData.id = docRef.id;
  taskData.dateTime = MyDateUtils.extractDateOnly(taskData.dateTime);
  return docRef.set(taskData);
}

Stream<QuerySnapshot<TaskData>> getTasksFromFireStore(DateTime dateTime) {
  return getTaskCollection()
      .where('dateTime',
          isEqualTo:
              MyDateUtils.extractDateOnly(dateTime).millisecondsSinceEpoch)
      .snapshots();
}

Future<void> deleteTaskFromFirestore(String id) {
  return getTaskCollection().doc(id).delete();
}

Future<void> editIsDone(TaskData task) {
  return getTaskCollection()
      .doc(task.id)
      .update({"isDone": task.isDone ? false : true});
}

Future<void> updateTask(TaskData task) async {
  return await getTaskCollection().doc(task.id).update({
    "title": task.title,
    "description": task.description,
    "dateTime":
        MyDateUtils.extractDateOnly(task.dateTime).millisecondsSinceEpoch
  });
}
