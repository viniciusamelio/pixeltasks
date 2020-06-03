import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class TaskAddAlert extends StatefulWidget {
  final int index;

  const TaskAddAlert({Key key, this.index}) : super(key: key);
  @override
  _TaskAddAlertState createState() => _TaskAddAlertState();
}

class _TaskAddAlertState extends State<TaskAddAlert> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Align(
          alignment: Alignment.center,
          child: Text(
            "Nova Tarefa",
            style: TextStyle(fontSize: 20),
          )),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height:5),
            TextFormField(
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            const SizedBox(height:5),
            TextFormField(
              decoration: InputDecoration(labelText: "Vencimento"),
            ),
            const SizedBox(height:20),
            SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 45,
            child: MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              ),
              color: green,
              child: Text("Confirmar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              onPressed: (){},
            ),
          )
          ],
        ),
      ),
    );
  }
}
