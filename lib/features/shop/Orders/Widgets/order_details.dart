import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../OrderModel/order_model.dart';
import 'order_status_helper.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});

  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(TSizes.defaultSpace),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.calendar),
                        SizedBox(width: TSizes.spaceBtwItems / 3),
                        Text(
                          "Order Date : ",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          order.orderDate,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        Icon(Iconsax.tag),
                        SizedBox(width: TSizes.spaceBtwItems / 3),

                        Text(
                          "Order Id : ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems / 2),
                        Text(
                          order.orderId,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems / 2),

                    Row(
                      children: [
                        OrderStatusHelper.orderStatusIcon(order.orderStatus),
                        SizedBox(width: TSizes.spaceBtwItems / 3),
                        Text(
                          "Status : ",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        Text(
                          order.orderStatus.name,
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: OrderStatusHelper.orderStatusText(
                              order.orderStatus,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        Icon(Iconsax.calendar_2),
                        SizedBox(width: TSizes.spaceBtwItems / 3),
                        Text(
                          "Delivery Date : ",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        Text(
                          order.deliveryDate,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),

          SizedBox(height: TSizes.spaceBtwItems),
      Divider(height: TSizes.dividerHeight*1.5),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                        "Items  ",
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: TColors.primary,)

                    ),

                    ListView.builder(
                      shrinkWrap: true, // Important when inside a SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // To prevent nested scrolling issues
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        final item = order.items[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              // 1. Image
                              CachedNetworkImage(imageUrl:
                                item.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 16),

                              // 2. Title & Variations
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Color: Blue, Size: 12',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),

                              // 3. Price & Quantity
                              Text(
                                '₹${item.price} x ${item.quantity}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(height: TSizes.dividerHeight*1.5),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: TSizes.spaceBtwItems),

                           Text(
                                "Delivery Address  ",
                                style: Theme.of(context).textTheme.titleLarge!.apply(
                                color: TColors.primary,)

                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.deliveryAddress.name,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium,
                              textAlign: TextAlign.start,
                            ),

                            Text(
                              order.deliveryAddress.phone,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium,
                            ),

                            Text(
                              "${order.deliveryAddress.street}, ${order.deliveryAddress.city}, ",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium,
                            ),
                            Text(
                              " ${order.deliveryAddress.state}  ${order.deliveryAddress.pinCode}",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium,
                            ),
                            Text(
                              order.deliveryAddress.country,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Divider(height: TSizes.dividerHeight*1.5),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Summary",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .apply(color: TColors.primary),
                              ),
                            ],
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Items Price : ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "₹ ${order.totalItemsPrice + order.shippingFee + order.discount}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              SizedBox(height: TSizes.spaceBtwItems / 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount : ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "₹ ${order.discount}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              SizedBox(height: TSizes.spaceBtwItems / 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "shipping charges : ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "₹ ${order.shippingFee}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              SizedBox(height: TSizes.spaceBtwItems),
                              Divider(height: TSizes.dividerHeight),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "final Price : ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "₹ ${order.totalItemsPrice}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              SizedBox(height: TSizes.spaceBtwItems / 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment - ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "cash on delivery",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .apply(color: TColors.primary),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
