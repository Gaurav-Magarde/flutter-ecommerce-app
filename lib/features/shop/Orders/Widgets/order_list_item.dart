import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/shimmer/address_shimmer.dart';
import 'package:clone_shopping/features/shop/Orders/OrderModel/order_model.dart';
import 'package:clone_shopping/features/shop/Orders/Widgets/order_details.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../OrderController/order_controller.dart';
import 'order_status_helper.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.fetchOrders();
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(title: Text("MY Orders"), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (controller.isLoading.value) {
            return AddressShimmer();
          }
          if (controller.orders.isEmpty) {
            return Center(child: Text("No Orders Found"));
          }
          return ListView.separated(
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final OrderModel order = controller.orders[index];
              return TRoundedContainer(

                showBorder: true,
                backgroundColor: dark ? TColors.dark : TColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: Row(

                        children: [
                          Text("Order Date : ",style: Theme.of(context).textTheme.titleMedium,),
                          Text(order.orderDate,style: Theme.of(context).textTheme.titleMedium,),

                          ]
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                          Row(
                            children: [
                              Container(
                                height: TSizes.defaultSpace * 4,
                                width: TSizes.defaultSpace * 4,
                                decoration: BoxDecoration(),
                                child: Image.network(
                                  order.items[0].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: TSizes.spaceBtwItems),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 118,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${order.items[0].title} ",

                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          if (order.items.length > 1)
                                            TextSpan(
                                              text:
                                                  "+ ${order.items.length-1} Other ",

                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.apply(
                                                    color: Colors.blue,
                                                    decoration:
                                                        TextDecoration.underline,
                                                  ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 118,
                                    child: Text(
                                      "₹ ${order.totalItemsPrice.toString()}",
                                      maxLines: 3,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),


                          IconButton(
                            onPressed: () {
                              Get.to(OrderDetails(order : order));
                            },
                            icon: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Iconsax.tag),
                                SizedBox(width: TSizes.spaceBtwItems),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order id",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            "[${order.orderId}",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "]",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                OrderStatusHelper.orderStatusIcon(order.orderStatus),
                                SizedBox(width: TSizes.spaceBtwItems),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery status",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                    Text(
                                      order.orderStatus.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .apply(
                                            color:
                                                OrderStatusHelper.orderStatusText(
                                                  order.orderStatus,
                                                ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
