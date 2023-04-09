import 'package:hive/hive.dart';

part 'ticket.g.dart';

@HiveType(typeId: 0)
class Ticket {
  @HiveField(0)
  String name;
  @HiveField(1)
  String link;
  @HiveField(2)
  double total;
  @HiveField(3)
  double doneByte;
  @HiveField(4)
  double progress;
  @HiveField(5)
  int status;
  @HiveField(6)
  String localFileName;

  Ticket({required this.name, required this.link, required this.total, required this.doneByte, required this.progress, required this.status, required this.localFileName});
}
