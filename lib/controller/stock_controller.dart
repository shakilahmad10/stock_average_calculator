import 'package:get/state_manager.dart';

class StockController extends GetxController {
  RxDouble averagePrice = 0.0.obs;
  RxInt totalUnits = 0.obs;
  RxDouble firstPurchase = 0.0.obs;
  RxDouble secondPurchase = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isVisible = false.obs;
  RxDouble priceDifference = 0.0.obs;

  void calculateAverage(int q1, double p1, int q2, double p2) {
    isVisible.value = true;
    if (q1 > 0 && p1 > 0 && q2 > 0 && p2 > 0) {
      firstPurchase.value = q1 * p1;
      secondPurchase.value = q2 * p2;
      priceDifference.value = p1 - p2;
      totalUnits.value = (q1 + q2).toInt();
      totalAmount.value = (q1 * p1) + (q2 * p2);
      averagePrice.value = totalAmount.value / totalUnits.value;
    } else {
      totalUnits.value = 0;
      totalAmount.value = 0.0;
      averagePrice.value = 0.0;
    }
  }

  void resetValues() {
    averagePrice.value = 0.0;
    totalAmount.value = 0.0;
    totalUnits.value = 0;
    isVisible.value = false;
  }
}
