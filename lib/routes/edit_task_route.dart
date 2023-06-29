import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lampfish/assets/palette/palette.dart';
import 'package:lampfish/components/datatypes/task.dart';

class EditTaskRoute extends StatefulWidget {
  final Task editingTask;
  const EditTaskRoute({
    super.key, required this.editingTask,
  });

  @override
  State<EditTaskRoute> createState() => _EditTaskRouteState();
}

class _EditTaskRouteState extends State<EditTaskRoute> {
  List<DateTime> pickedDate = [];

  @override
  void initState() {
    super.initState();
    pickedDate = [DateTime.now()];
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 80,
              color: PaletteOne.primaryColor.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(top: 30)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 30,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.chevron_left, color: PaletteOne.secondaryColor, size: 20),
                              SizedBox(width: 10,),
                              Text('Back', style: TextStyle(color: PaletteOne.secondaryColor, fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text('Edit Task', style: TextStyle(
                        color: PaletteOne.secondaryColor, fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          onPressed: () {

                          },
                          icon: Icon(Icons.more_horiz, size: 25),
                            /*child: const Text('Delete', style: TextStyle(
                                color: PaletteOne.primaryColor, fontSize: 18),
                            ),*/
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            onFieldSubmitted: (value) {

                            },
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(height: 0),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  )),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  )),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                              filled: true,
                              fillColor: PaletteOne.secondaryColor.shade100,
                              hintText: 'Title',
                              hintStyle: const TextStyle(
                                color: PaletteOne.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50.0),
                                gapPadding: 0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: 50,
                          child: DropdownButton<DateTime>(
                              hint: const Text('Choose A Date'),
                              items: pickedDate.map((e) => DropdownMenuItem<DateTime>(child: Text(DateFormat('EEEE, MMMM dd yyyy').format(e)))).toList(),
                              onChanged: (DateTime? value) {
                                setState(() {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2099)
                                  ).then((date) {
                                    setState(() {
                                      pickedDate = [date!];
                                    });
                                  });
                                });
                              })
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
