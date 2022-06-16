import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key key}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {

  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.7), width: 0.75),
          borderRadius: BorderRadius.circular(6)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: InkWell(
        onTap: () async{
          date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2028));
          if(date!=null){
            setState((){});
          }
        },
        child: Row(
          children: [
            Text("Start Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            Spacer(),
            Text((date==null) ? "--SELECT--" : DateFormat('yyyy-MM-dd ').format(date), style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[700])),
            SizedBox(width: 30,)
          ],
        ),
      ),

    );
  }
}
