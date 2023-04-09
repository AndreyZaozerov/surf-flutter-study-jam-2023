import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/features/model/ticket.dart';
import 'package:surf_flutter_study_jam_2023/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {

  final _formKey = GlobalKey<FormState>();
  String? initValue;
  final linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 5.0,
              width: 40.0,
              color: Colors.black38,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: linkController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      labelText: 'Введите url',
                    ),
                    initialValue: initValue,
                    onSaved: (String? value) {

                    },
                    validator: (String? value) {
                      if (value == null || !value.contains('pdf')) {
                        return 'Введите корректный URL';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                          List<String> s = linkController.text.split('/');
                          String name = s.last.split('.').first;

                          Box<Ticket> ticketBox = Hive.box<Ticket>(ticketBoxName);
                          ticketBox.add(Ticket(name: name, link: linkController.text, total: 0, doneByte: 0, progress: 0, status: 0, localFileName: ''));
                          showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.info(message: 'Ссылка добавлена', icon: Icon(null),)
                          );
                          
                          Navigator.pop(context);
                      };
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        foregroundColor: Colors.white
                    ),
                    child: const Text('Добавить'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
