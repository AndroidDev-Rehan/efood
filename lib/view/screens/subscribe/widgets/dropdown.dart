import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  String dropdownValue;
  final List<String> items;
  final String hint;

  MyDropDownButton({Key key, this.dropdownValue, @required this.items, this.hint}) : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  // String dropdownValue = widget.dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7), width: 0.75),
        borderRadius: BorderRadius.circular(6)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: DropdownButton<String>(
        hint: (widget.hint!=null) ? Text(widget.hint, style: TextStyle(fontWeight: FontWeight.normal),) : null,
        // disabledHint: Text("--package--"),
        isExpanded: true,
        value: widget.dropdownValue,
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        // elevation: 16,
        // style: const TextStyle(color: Colors.deepPurple),
        underline: const SizedBox(
          height: 0,
          width: 0,
        ),
        onChanged: (String newValue) {
          setState(() {
            widget.dropdownValue = newValue;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          );
        }).toList(),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
