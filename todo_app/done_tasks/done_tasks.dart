import 'package:abdullaa/shared/compounant/compounts.dart';

import 'package:abdullaa/shared/cubit/cubit.dart';
import 'package:abdullaa/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class done_task extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        var tasks=AppCubit.get(context).donetasks;

        return ListView.separated(
          itemBuilder:(context, index) =>  buildTaskItem(tasks[index],context),
          separatorBuilder: (context, index) =>Container(
            width: double.infinity,
            height:1,
            color: Colors.grey,
          ) ,
          itemCount:tasks.length,
        );
      },
    );

  }
}
