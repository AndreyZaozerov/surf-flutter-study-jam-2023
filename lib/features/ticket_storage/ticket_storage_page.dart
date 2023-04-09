import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/input_form.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/ticket_card.dart';
import 'package:surf_flutter_study_jam_2023/main.dart';

import '../model/ticket.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  Widget addBtn(BuildContext context){
    return SizedBox(
      width: 120,
      child: FloatingActionButton(
        onPressed: ()=>addBottomSheet(context),
        child: const Text('Добавить'),
      ),
    );
  }

  Widget downloadBtn(){
    return SizedBox(
      width: 120,
      child: FloatingActionButton(
        onPressed: () { },
        child: const Text('Загрузить всё'),
      ),
    );
  }

  Future addBottomSheet(BuildContext context){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: true,
        enableDrag: true,
        builder: (BuildContext context){
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const InputForm(),
          );
        }
    );
  }

   Widget getHiveList(){
    return ValueListenableBuilder(
        valueListenable: Hive.box<Ticket>(ticketBoxName).listenable(),
        builder: (context, Box<Ticket> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Здесь пока ни чего нет'),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Ticket? t = box.getAt(index);
                return TicketCard(ticket: t!, index: index);
              }
          );
        }
    );
   }


  @override
  Widget build(BuildContext context) {
    // return const FlutterLogo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранение билетов'),
      ),
      body: getHiveList(), //ticketsData.isEmpty ? clearBody() : ticketList(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          addBtn(context),
          // const SizedBox(
          //   width: 10,
          // ),
          // downloadBtn(),
        ],
      ),
    );
  }
}


