import 'package:abdullaa/shared/compounant/compounts.dart';

import 'package:abdullaa/shared/cubit/cubit.dart';
import 'package:abdullaa/shared/cubit/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class  archieve_task extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        var tasks=AppCubit.get(context).archivedtasks;

        return ConditionalBuilder(
          condition: false,
          builder: (context) => ListView.separated(
            itemBuilder:(context, index) =>  buildTaskItem(tasks[index],context),
            separatorBuilder: (context, index) =>Container(
              width: double.infinity,
              height:1,
              color: Colors.grey,
            ) ,
            itemCount:tasks.length,
          ),
          fallback: (context) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 50,
                ),
                Text(
                    'No Tasks Yet',
                  style:TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
