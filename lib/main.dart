import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_storage_page.dart';

import 'features/model/ticket.dart';

const String ticketBoxName = "tickets4";

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TicketAdapter());
  await Hive.openBox<Ticket>(ticketBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const TicketStoragePage(),
    );
  }
}

