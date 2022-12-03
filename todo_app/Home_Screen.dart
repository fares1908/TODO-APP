

import 'package:abdullaa/moduls/new%20_tasks/new_tasks.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/cubit/cubit.dart';
import 'package:abdullaa/shared/cubit/state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class Home_Layout extends StatelessWidget {




  bool bottomsSheetShown=false;
  IconData fabicon=Icons.edit;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context) =>AppCubit()..createDatabase(),
    child: BlocConsumer<AppCubit , AppState>(
      listener: (BuildContext context, AppState state ){
    if(state is AppStateInsert){
      Navigator.pop(context);

    }
      },
      builder: (context , state){
        AppCubit cubit=AppCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title:Text(
              cubit.titles[cubit.currentIndex],
            ),

          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex,
            elevation:20,
            onTap:(index){
              cubit.changNav(index);
            } ,
            items: [
              BottomNavigationBarItem(
                  label: 'Tasks',
                  icon: Icon(
                    Icons.menu,
                  )

              ),
              BottomNavigationBarItem(
                  label: 'Done',
                  icon: Icon(
                    Icons.check_box,
                  )
              ),
              BottomNavigationBarItem(
                  label: 'Archive',
                  icon: Icon(
                    Icons.archive,
                  )
              ),

            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(cubit.bottomsSheetShown){
                if(formKey.currentState!.validate()) {
                  cubit.insertDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                  );
                //   insertDatabase(
                //     date: dateController.text,
                //     time: timeController.text,
                //     title: titleController.text,
                //
                //   ).then((value) {
                //     Navigator.pop(context);
                //     bottomsSheetShown = false;
                //     // setState(() {
                //     // fabicon = Icons.edit;
                //     // });
                //     // عملت زين عشان اضمن انخ مش هيقفل غير لما ينفذ
                //
                //   });
                }


              }
              else{
                // او هنا نقفول اعمل كدخ
                cubit.changeBottomSheetShow(
                    isShow: true,
                    icon: Icons.add,
                );
                scaffoldKey.currentState?.showBottomSheet((context) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey[200],
                        child: Form(
                          key: formKey,

                          child: Column(

                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: deflutformfield(

                                    controller: titleController,
                                    type: TextInputType.text,

                                    label:'Task title',
                                    icon: Icons.text_fields,
                                    validate:(value){
                                      if(value.isEmpty){
                                        return
                                          "Title Must Not Be Empty";
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: deflutformfield(
                                    onTap: () {
                                      showTimePicker(
                                          context: context,
                                          initialTime:TimeOfDay.now()
                                      ).then((value) {
                                        timeController.text=value!.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    controller: timeController,
                                    type:TextInputType.datetime,
                                    label:'Task Time',
                                    icon: Icons.timer,
                                    validate:( value){
                                      if(value.isEmpty) {
                                        return"Time Must Not Be Empty";
                                      }
                                      return null;
                                    }
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: deflutformfield(
                                    onTap:(){
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2035)
                                      ).then((value) {
                                        dateController.text=DateFormat.yMMMd().format(value!);
                                      });

                                    },

                                    controller: dateController,
                                    type:TextInputType.datetime,
                                    label:'Task date',
                                    icon: Icons.date_range,
                                    validate:( value){
                                      if(value.isEmpty){
                                        return "Date Must Not Be Empty";
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ).closed.then((value) {
                  cubit.changeBottomSheetShow(
                      isShow: false,
                      icon: Icons.edit,
                  );
                });

              }
            },
            backgroundColor: Colors.teal,
            child: Icon(
              cubit.fabicon,

            ),
          ),
          body: cubit.Screens[cubit.currentIndex],

        );
      },

    ),
  );
  }


  }



