import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/input_form.dart';


final _formKey = GlobalKey<FormState>();

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatelessWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  Widget clearBody(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Здесь пока ни чего нет'),
        ],
      ),
    );
  }


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
        builder: (BuildContext context){
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SizedBox(
              height: 250,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                child: InputForm(),
              ),
            ),
          );
        }
    );
  }
  // Future addBottomSheet(BuildContext context){
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context){
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: SizedBox(
  //             height: 230,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
  //               child: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: [
  //                     Column(
  //                       children: [
  //                         TextFormField(
  //                           decoration: const InputDecoration(
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.all(Radius.circular(10.0))
  //                             ),
  //                             labelText: 'Введите url',
  //                           ),
  //                           onSaved: (String? value) {
  //
  //                           },
  //                           validator: (String? value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'Введите корректный URL';
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //                         const SizedBox(height: 20.0),
  //                         ElevatedButton(
  //                           onPressed: () {
  //                             if (_formKey.currentState!.validate()) {
  //                               ScaffoldMessenger.of(context).showSnackBar(
  //                                   const SnackBar(content: Text('Processing Data'))
  //                               );
  //                             }
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.black12,
  //                               foregroundColor: Colors.white
  //                           ),
  //                           child: const Text('Добавить'),
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    // return const FlutterLogo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранение билетов'),
      ),
      body: clearBody(),
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
