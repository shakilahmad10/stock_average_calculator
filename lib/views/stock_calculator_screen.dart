import 'package:average_cal/controller/stock_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class StockCalculatorScreen extends StatelessWidget {
  const StockCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstQuantityController = TextEditingController();
    TextEditingController secondQuantityController = TextEditingController();
    TextEditingController firstPriceController = TextEditingController();
    TextEditingController secondPriceController = TextEditingController();

    StockController stockController = StockController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Stock Average Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "First purchage",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(height: 10),
            _buildInputField(
                "Units", "Enter quantity", firstQuantityController),

            const SizedBox(height: 10),
            _buildInputField("Price per Share", "Enter the price per share",
                firstPriceController),
            const SizedBox(height: 20),
            //second---------------------------------------------------
            Text(
              "Second purchage",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(height: 10),
            _buildInputField(
                "Units", "Enter quantity", secondQuantityController),
            const SizedBox(height: 10),
            _buildInputField("Price per Share", "Enter the price per share",
                secondPriceController),
            const SizedBox(height: 20),

            //button row
            Row(
              children: [
                //elevated button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("clearing the fields");
                      firstQuantityController.clear();
                      firstPriceController.clear();
                      secondQuantityController.clear();
                      secondPriceController.clear();

                      stockController.resetValues();
                    },
                    style: _buildButtonStyle(Colors.amber),
                    child: Text(
                      "Clear Fields",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Calculating the average....");
                      final firstQty = firstQuantityController.text;
                      final firstPrice = firstPriceController.text;
                      final secondQty = secondQuantityController.text;
                      final secondPrice = secondPriceController.text;

                      if (firstQty.isEmpty ||
                          firstPrice.isEmpty ||
                          secondQty.isEmpty ||
                          secondPrice.isEmpty) {
                        //show message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please fill all fields."),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }

                      //input parse to double
                      final int q1 = int.tryParse(firstQty) ?? 0;
                      final double p1 = double.tryParse(firstPrice) ?? 0;
                      final int q2 = int.tryParse(secondQty) ?? 0;
                      final double p2 = double.tryParse(secondPrice) ?? 0;

                      if (q1 <= 0 || p1 <= 0 || q2 <= 0 || p2 <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter valid positive numbers."),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }

                      stockController.calculateAverage(q1, p1, q2, p2);
                    },
                    style: _buildButtonStyle(Colors.green),
                    child: Text(
                      "Calculate Average",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Diplay calculated Average value
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customTextDisplay("Total Units: ",
                      stockController.totalUnits.value.toString()),
                  _customTextDisplay("Average Price: ",
                      stockController.averagePrice.value.toStringAsFixed(2)),
                  _customTextDisplay("Total Amount: ",
                      stockController.totalAmount.value.toStringAsFixed(2)),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _customTextDisplay(String label, String value) {
    print("$label $value"); // Log label and value for debugging

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align text in a straight column
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 13, 136, 17),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  ButtonStyle _buildButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
    );
  }
}
