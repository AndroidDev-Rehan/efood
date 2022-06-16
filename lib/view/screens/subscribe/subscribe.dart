import 'package:flutter/material.dart';
import 'package:flutter_restaurant/view/screens/subscribe/widgets/datepicker.dart';
import 'package:flutter_restaurant/view/screens/subscribe/widgets/dropdown.dart';

import '../../../helper/responsive_helper.dart';
import '../../../utill/dimensions.dart';
import '../../base/custom_button.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Subscribe Product", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
          Icon(Icons.shopping_cart),
          SizedBox(width: 5,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Text("MRP: ₹", style: TextStyle(fontSize: 18)),
                Text("300.00", style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18),),
                SizedBox(width: 12,),
                Text("Save: ₹130.00", style: TextStyle(fontSize: 18, color: Colors.red)),

              ],
            ),
            SizedBox(height: 10,),
            MyDropDownButton(dropdownValue: "Dried Double Beans (500 gm)", items: ["Dried Double Beans (500 gm)", "Double Beans (1000 gm)"]),
            SizedBox(height: 10,),
            QuantityContainer(),
            SizedBox(height: 10,),
            Text("Choose Package", style: TextStyle(fontSize: 16),),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: MyDropDownButton(items: ["Daily", "Weekdays", "Weekends"],hint: "--Package--",)),
                SizedBox(width: 20,),
                Expanded(child: MyDropDownButton(items: ["15 deliveries", "30 deliveries", "10 deliveries"], hint: "--Deliveries--")),
              ],
            ),
            SizedBox(height: 15,),
            Text("Customise Delivery Days", style: TextStyle(fontSize: 16)),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Wrap(
                spacing: 25,
                runSpacing: 20,
                children: [
                WeekendCheckBox(weekday: "Monday"),
                WeekendCheckBox(weekday: "Tuesday"),
                WeekendCheckBox(weekday: "Wednesday"),
                WeekendCheckBox(weekday: "Thursday"),
                WeekendCheckBox(weekday: "Friday"),
                WeekendCheckBox(weekday: "Saturday"),
                WeekendCheckBox(weekday: "Sunday"),

              ],),
            ),
            SizedBox(height: 15,),
            MyDatePicker(),
            SizedBox(height: 35,),
            if(!ResponsiveHelper.isDesktop(context))  Container(
                width: 1170,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: CustomButton(btnTxt: "Subscribe", backgroundColor: Colors.green, onTap: (){
                  Navigator.pop(context);
                  },))

          ],
        ),
      ),
    );
  }
}

class WeekendCheckBox extends StatefulWidget {
  const WeekendCheckBox({Key key, @required this.weekday}) : super(key: key);

  final String weekday;

  @override
  State<WeekendCheckBox> createState() => _WeekendCheckBoxState();
}

class _WeekendCheckBoxState extends State<WeekendCheckBox> {

  bool checked = false;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        !checked ? InkWell(
            child: Icon(Icons.check_box_outline_blank),
          onTap: (){
              checked=!checked;
              setState((){

              });
          },

        )
        : InkWell(
            child: Icon(Icons.check_box, color: Colors.blue,),
            onTap: (){
              checked=!checked;
              setState((){});
            }
        ),
        SizedBox(width: 15,),
        Text(widget.weekday)
      ],
    );
  }
}

class QuantityContainer extends StatefulWidget {
  const QuantityContainer({Key key}) : super(key: key);

  @override
  State<QuantityContainer> createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityContainer> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return             Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.7), width: 0.75),
          borderRadius: BorderRadius.circular(6)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Row(
        children: [
          Icon(Icons.menu),
          SizedBox(width: 25,),
          Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
          Spacer(),
          Text(quantity.toString(), style: TextStyle(fontSize: 20, color: Colors.green),),
          SizedBox(width: 10,),
          InkWell(
              onTap: (){
                quantity++;
                setState((){});
              },
              child: Icon(Icons.add))
        ],
      ),
    );
  }
}


