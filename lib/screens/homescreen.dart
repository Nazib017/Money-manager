import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:money_management/controllers/amount_controller.dart';
import 'package:money_management/controllers/expanse_controller.dart';
import 'package:money_management/models/amount_model.dart';
import 'package:money_management/models/expanse_model.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';



class HomeScreen extends StatelessWidget{

  TextEditingController amnclt=TextEditingController();
  TextEditingController exclt=TextEditingController();
  TextEditingController addAmount=TextEditingController();
  TextEditingController Description=TextEditingController();
  ExController exController=Get.put(ExController());
  AmountController amountController=Get.put(AmountController());
  Box ExpenseBox=Hive.box("Expense");
  Box amountBox=Hive.box("CurrentM");
  Box AddMoneyBox=Hive.box("AddMoney");
  MySnackBar(message,context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Dashboard",style: TextStyle(color: Colors.white,fontSize: 24,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
       backgroundColor: Colors.blueGrey[400],
       centerTitle: true,

     ),
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: SizedBox(
               width: 400,
               height: 200,
               child: Card(
                 shadowColor: Colors.black87,
                 elevation: 20,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     GetBuilder<AmountController>(
                       builder: (controller) {
                         return ValueListenableBuilder(
                           valueListenable: amountBox.listenable(),
                           builder: (context,amountBox, child) {
                             return Text(
                               "Balance: ${controller.current}",
                               style: TextStyle(
                                   fontWeight: FontWeight.bold, fontSize: 20),
                             );
                           }
                         );
                       },
                     ),
                     SizedBox(height: 60,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         ElevatedButton(onPressed: (){
                           _showAddDialogue(context);
                         }, child: Text("Add Money"),
                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                           backgroundColor: Colors.blueGrey,
                           foregroundColor: Colors.white
                         ),
                         ),
                         ElevatedButton(onPressed: (){
                           _showDialogue(context);
                         }, child: Text("Expense"),
                           style: ElevatedButton.styleFrom(
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                               backgroundColor: Colors.blueGrey,
                               foregroundColor: Colors.white
                           ),
                         ),
                       ],
                     )

                   ],
                 ),
               ),
             ),
           ),
         ),
         SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("Recent History",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),

         ),
         Expanded(
           child: DefaultTabController(
             length: 2,
             child: Column(
           
               children: [
                 TabBar(

                   tabs: [
                     Tab(text: 'Expense History'),
                     Tab(text: "Add Money History",)
                   ],
                 ),
                 Expanded(
           
                   child: TabBarView(
           
                     children: [
           
                       GetBuilder<ExController>(builder: (context) {
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ValueListenableBuilder(
                               valueListenable: ExpenseBox.listenable(),
                               builder: (context,ExpenseBox, child) {
                                 return  ListView.separated(
           
                                   reverse: false,
                                   //shrinkWrap: true,
                                   itemCount: ExpenseBox.keys.length,
                                   itemBuilder: (context, index) {
                                     ExModel ex=ExpenseBox.getAt(index);
                                     // ExModel ex = exController.historys[index];
                                     String formattedDate =
                                     DateFormat('yyyy-MM-dd').format(ex.dateTime);
                                     return
                                       ListTile(
                                         leading: Text(
                                           formattedDate,
                                           style: TextStyle(fontSize: 14),
                                         ),
                                         title: Text(
                                           ex.expanse,
                                           style: TextStyle(
                                               fontSize: 18, fontWeight: FontWeight.w400),
                                         ),
                                         trailing: Text(
                                           "-${ex.amount}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 18,
                                               color: Colors.red),
                                         ),
                                       );
           
                                   },
                                   separatorBuilder: (context,index){
                                     return Divider(
                                       color: Colors.grey,
                                      // indent: 2,
                                      // endIndent: 2,
                                       thickness: 2,
                                       height: 0,


                                     );
                                   },
                                 );
                               }
                           ),
                         );
                       }),

                       GetBuilder<AmountController>(builder: (context) {
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ValueListenableBuilder(
                               valueListenable: AddMoneyBox.listenable(),
                               builder: (context,AddMoneyBox, child) {
                                 return ListView.separated(

                                   reverse: false,
                                   //shrinkWrap: true,
                                   itemCount: AddMoneyBox.keys.length,
                                   itemBuilder: (context, index) {
                                     AmountModel Amnt =AddMoneyBox.getAt(index);
                                     String Date =
                                     DateFormat('yyyy-MM-dd').format(Amnt.dateTimeAdd);
                                     return
                                       ListTile(
                                         leading: Text(
                                           Date,
                                           style: TextStyle(fontSize: 14),
                                         ),
                                         title: Text(
                                           Amnt.DescriptionToAdd,
                                           style: TextStyle(
                                               fontSize: 18, fontWeight: FontWeight.w400),
                                         ),
                                         trailing: Text(
                                           "+${Amnt.amountToAdd}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 18,
                                               color: Colors.green),
                                         ),
                                       );

                                   },
                                   separatorBuilder: (context,index){
                                     return Divider(
                                       color: Colors.grey,
                                       // indent: 2,
                                       // endIndent: 2,
                                       thickness: 2,
                                       height: 0,

                                     );
                                   },
                                 );
                               }
                           ),
                         );
                       }),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),





       ],
     ),

   );
  }

  _showDialogue(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amnclt,
                  decoration: InputDecoration(
                    hintText: "Enter Expense",
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: exclt,
                  decoration: InputDecoration(
                    hintText: "Expense Description",
                  ),
                ),


              ],
            ) ,
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                child: Text('Cancel',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              ElevatedButton(onPressed: (){
                double Amount=double.parse(amnclt.text);
                if(Amount>amountController.current ){
                  MySnackBar("You have not enough money", context);
                  Navigator.pop(context);
                }
                else if(Amount<=0){
                  MySnackBar("Invalid Amount", context);
                }
                else if(exclt.text==""){
                  MySnackBar("Write Description", context);
                }
                else{
               exController.createHistory(ExModel(Amount, exclt.text,DateTime.now()));
               amountController.spendMoney(Amount);
                Navigator.pop(context);}
              },
                child: Text('Add',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _showAddDialogue(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: addAmount,
                  decoration: InputDecoration(
                    hintText: "Add Amount",
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: Description,
                  decoration: InputDecoration(

                    hintText: "Source",
                  ),
                ),


              ],
            ) ,
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                child: Text('Cancel',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              ElevatedButton(onPressed: (){

                double currentMoney =double.parse(addAmount.text);
                if(currentMoney<=0){
                  MySnackBar("Invalid Amount", context);

                }
                else if(Description.text==""){
                  MySnackBar("Write Source", context);

                }
                else{
                amountController.Addmoney(currentMoney);
                amountController.historyAddMoney(AmountModel(currentMoney, Description.text, DateTime.now(),));
                Navigator.pop(context);}

              },
                child: Text('Add',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }


}