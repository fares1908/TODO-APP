

import 'package:abdullaa/lay_out/todo_app/done_tasks/done_tasks.dart';

import 'package:abdullaa/moduls/new%20_tasks/new_tasks.dart';
import 'package:abdullaa/shared/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'archieve_tasks/archieve_task.dart';

class AppCubit extends Cubit<AppState>{
 AppCubit():super(intilState());
 static AppCubit get(context)=>BlocProvider.of(context);
 int currentIndex=0;
 List<Widget>Screens=[
  new_task(),
  done_task(),
  archieve_task(),

 ];
 bool bottomsSheetShown=false;
 IconData fabicon=Icons.edit;
 Database ?database;
 List<Map>newtasks=[];
 List<Map>donetasks=[];
 List<Map>archivedtasks=[];

 List<String>titles=[
  'New Tasks',
  'Done Tasks',
  'Done Tasks',
 ];
 void changNav(int index){
  currentIndex=index;


  emit(ChangeBottomNav());
 }
 void createDatabase(
     ){
 openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
       print('database created');
       database.execute(
           'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT , time TEXT, status TEXT)'
       ).then((value)  {
        print('table  created');

       }).catchError((error){
        print("Error when created table${error.toString()}");
       });

      },
      onOpen: (database){
       getDataFromDatabase(database);
       print('database opened');
      },
  ).then((value) {
   database=value;
   emit(AppStateCreateDataBase());
 });
 }
  insertDatabase({

  required String title,
  required String time,
  required String date,

 })async{
   await database?.transaction((txn)async{
    await txn.rawInsert(
    'INSERT INTO tasks (title, date, time , status)VALUES("$title", "$date","$time","new")',
   ).then((value) {
    print('$value inserted successfully');
    emit(AppStateInsert());
    getDataFromDatabase(database);


   }).catchError((error){
    print("Error insert ${error.toString()} ");
   });

  });
 }
void getDataFromDatabase(database){
  newtasks=[];
  donetasks=[];
  archivedtasks=[];

 database!.rawQuery('SELECT * FROM tasks').then((value) {

  value.forEach((element){
   if(element['status']=='new')
   newtasks.add(element);

   else if(element['status']=='Done')
   donetasks.add(element);
   else
    archivedtasks.add(element);

  });
  emit(AppStateGetFromDataBase());

 });


 }




 void changeBottomSheetShow({
 required bool isShow,
 required IconData icon,
}){
  bottomsSheetShown=isShow;
  fabicon=icon;
  emit(ChangeBottomSheet());
}

void updateData({
 required String  status,
 required int id,
})async{
  database?.rawUpdate(
     'UPDATE tasks SET status = ? WHERE id = ?',
     [status, id],
 ).then((value) {
   getDataFromDatabase(database);
  emit(AppStateUpdateDataBase());
  });

}
 void deleteData({

   required int id,
 })async {
   database?.rawDelete('DELETE FROM tasks WHERE id = ?',
     [id],
   ).then((value) {
     getDataFromDatabase(database);
     emit(AppStateDeleteDataBase());
   });
 }

 }