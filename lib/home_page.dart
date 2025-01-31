import 'package:assignment_twenty_two/categories_shimmer.dart';
import 'package:assignment_twenty_two/home_controller.dart';
import 'package:assignment_twenty_two/product_model.dart';
import 'package:assignment_twenty_two/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: GetBuilder<HomeController>(builder: (_) {
              return homeController.isCategoryLoading
                  ? CategoriesShimmer()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              homeController.getProductsByCategory(
                                  homeController.categories[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Text(
                                  homeController.categories[index]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ),
                        );
                      });
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              builder: (_) {
                return homeController.isLoading
                    ? ProductShimmer()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: homeController.products.length,
                            itemBuilder: (context, index) {
                              ProductModel product =
                                  homeController.products[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        product.image!,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        product.title!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Price: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                product.price.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 18.0,
                                              ),
                                              Text(
                                                product.rating!.rate.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
