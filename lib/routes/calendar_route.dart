import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lampfish/components/datatypes/task.dart';

class TaskRoute extends StatefulWidget {
  final List<String> listUnformattedTasks;
  const TaskRoute({
    super.key,
    required this.listUnformattedTasks,
  });

  @override
  State<TaskRoute> createState() => _TaskRouteState();
}

class _TaskRouteState extends State<TaskRoute> {
  late List<Task> listTask;

  @override
  void initState() {
    super.initState();
    listTask = _initializeTasks(widget.listUnformattedTasks);
  }

  List<Task> _initializeTasks(List<String> tasks) {
    List<Task> returnableTask = [];
    for (var task in tasks) {
      returnableTask.add(
          Task(
            startTime: DateTime.now(),
            deadline: null,
            taskTitle: task,
            taskDesc: '',
            priority: TaskPriority.NONE,
          )
      );
    }
    return returnableTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: ListView.builder(
          itemCount: listTask.length,
          itemBuilder: (context, index) {
            return SizedBox(
              child: Column(
                children: [
                  Text('TITLE: ${listTask[index].taskTitle}'),
                  Text('DESCRIPTION: ${listTask[index].taskDesc}'),
                  Text('PRIORITY: ${listTask[index].priority}'),
                  Text('START: ${DateFormat('EEEE, MMMM dd yyyy hh:mm a').format(listTask[index].startTime!)}'),
                  Text('DEADLINE: ${listTask[index].deadline}'),
                  const SizedBox(height: 20,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
