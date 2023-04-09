import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/features/model/ticket.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:open_filex/open_filex.dart';

import '../../main.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final int index;

  double progress = 0;
  bool didDownloadPDF = false;

  TicketCard({Key? key, required this.ticket, required this.index}) : super(key: key);

  Box<Ticket> ticketBox = Hive.box<Ticket>(ticketBoxName);

  void delete(){
    ticketBox.deleteAt(index);
  }

  void updateProgress(done, total) {
    progress = done / total;

    ticket.progress = progress;
    ticket.total = total/(1024*1024);
    ticket.doneByte = done/(1024*1024);
    ticket.status = 1;

    ticketBox.putAt(index, ticket);
  }

  Future download(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) { return status! < 500; }
        ),
      );

      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();

      ticket.status = 2;
      ticketBox.putAt(index, ticket);

    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadStart() async {
    var appDir = await getApplicationDocumentsDirectory();
    String uuid = const Uuid().v1();
    String savePath = '${appDir.path}$uuid.pdf';
    ticket.localFileName = savePath;
    ticketBox.putAt(index, ticket);
    download(Dio(), ticket.link, savePath);
  }


  String getSubtitle() {
    String text = 'Ожидает начало загрузки';
    if(ticket.status == 1) {
      text = 'Загружается ${ticket.doneByte.toStringAsFixed(2)} из ${ticket.total.toStringAsFixed(2)}';
    }
    if(ticket.status == 2) {
      text = 'Файл загружен';
    }

    return text;
  }


  void openPdf() {
    OpenFilex.open(ticket.localFileName);
  }

  Widget getTrailing() {
    if(ticket.status == 0) {
      return IconButton(
          onPressed: ()=>downloadStart(),
          icon: const Icon(Icons.cloud_download)
      );
    }

    if(ticket.status == 1) {
      return IconButton(
          onPressed: (){},
          icon: const Icon(Icons.pause_circle_outline)
      );
    }

    if(ticket.status == 2) {
      return IconButton(
          onPressed: ()=> openPdf(),
          icon: const Icon(Icons.file_open)
      );
    }

    return const Icon(Icons.warning_amber);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.airplane_ticket),
      title: Text(ticket.name),
      subtitle: Column(
        children: [
          LinearProgressIndicator(
            value: ticket.progress,

          ),
          Text(getSubtitle()),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     IconButton(onPressed: ()=>delete(), icon: const Icon(Icons.delete))
          //   ],
          // )
        ],
      ),
      trailing: getTrailing()
    );
  }
}

