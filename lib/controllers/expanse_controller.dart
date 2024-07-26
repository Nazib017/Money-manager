import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:money_management/models/expanse_model.dart';

class ExController extends GetxController{
  //List<ExModel>historys=[];
  Box ExpenseBox=Hive.box("Expense");
  void createHistory(ExModel history){
   // historys.add(history);
    ExpenseBox.add(history);
    update();
  }

}