class TaskModel{
  String id;
  String title;
  String description;
  int dateTime;
  bool isDone;
  TaskModel.fromjoison(Map<String,dynamic> joson):this(
  id:joson['id'] as String,
  title:joson['title'] as String,
  description:joson['description'] as String,
  dateTime:joson['datetime'] as int,
  isDone:joson['isdone'] as bool
  );
  TaskModel({this.id='',required this.title,required this.description,required this.dateTime,this.isDone=false});
  Map<String,dynamic> tojoison(){
    return {
      'id':id,
      'title':title,
      'description':description,
      'datetime':dateTime,
      'isdone':isDone

    };
  }
}