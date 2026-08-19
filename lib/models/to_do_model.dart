import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

//adaptor generator codeline
part 'to_do_model.g.dart';

@HiveType(typeId: 2)
class ToDoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final bool isDone;

  ToDoModel({
    String? id,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  }) : id = id ?? const Uuid().v4();
}
