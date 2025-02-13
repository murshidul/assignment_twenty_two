import 'package:assignment_twenty_two/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProductPage extends StatelessWidget {
  DeleteProductPage({super.key});

  final TextEditingController productIdClt = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: TextField(
                controller: productIdClt,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Product ID",
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                homeController.deleteProduct(productIdClt.text);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrangeAccent,
                ),
                width: Get.width,
                height: 45.0,
                child: Center(
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
