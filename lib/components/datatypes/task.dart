// ignore_for_file: constant_identifier_names

class Task {
  final String taskTitle;
  final String taskDesc;
  final DateTime? startTime;
  final DateTime? deadline;
  final TaskPriority priority;
  Task({
    required this.taskTitle,
    this.taskDesc = '',
    this.priority = TaskPriority.NONE,
    required this.startTime,
    required this.deadline,
  });
}

enum TaskPriority{
  DO,
  DECIDE,
  DELEGATE,
  DONT,
  NONE,
}

enum TaskStatus{
  DONE,
  IN_PROGRESS,
  CANCELED,
}