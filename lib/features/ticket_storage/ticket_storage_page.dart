import 'package:flutter/material.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);


  Widget clearBody(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Здесь пока ни чего нет"),
        ],
      ),
    );
  }


  Widget addBtn(){
    return SizedBox(
      width: 120,
      child: FloatingActionButton(
        onPressed: () { },
        child: const Text("Добавить"),
      ),
    );
  }

  Widget downloadBtn(){
    return SizedBox(
      width: 120,
      child: FloatingActionButton(
        onPressed: () { },
        child: const Text("Загрузить всё"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return const FlutterLogo();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Хранение билетов"),
      ),
      body: clearBody(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          addBtn(),
          // const SizedBox(
          //   width: 10,
          // ),
          // downloadBtn(),
        ],
      ),
    );
  }
}
