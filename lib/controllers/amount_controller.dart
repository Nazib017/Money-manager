import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:money_management/models/amount_model.dart';

class AmountController extends GetxController{
 late Box amountBox;
 late double current;
 Box AddMoneyBox=Hive.box("AddMoney");

 @override
 void onInit() {
  super.onInit();
  amountBox = Hive.box("CurrentM");

  current = amountBox.get("CurrentMoney", defaultValue: 0.0);
 }
void Addmoney(double currentmon ){
 current+=currentmon;
 amountBox.put("CurrentMoney", current);
 update();
}
void spendMoney(double amount) {
 current -= amount;
 amountBox.put("CurrentMoney", current);
 update();
}
void historyAddMoney(AmountModel ModelAmount){
  AddMoneyBox.add(ModelAmount);
  update();
}

}