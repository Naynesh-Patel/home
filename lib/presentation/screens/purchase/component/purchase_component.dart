import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/presentation/utils/utils.dart';
import '../../../../data/model/order/single_order_model.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/primary_button.dart';

class PurchaseComponent extends StatelessWidget {
  const PurchaseComponent({Key? key, required this.singleOrder})
      : super(key: key);
  final SingleOrderModel singleOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      //height: 200.0.h,
      margin: EdgeInsets.symmetric(vertical: 8.0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextStyle(
                text: Utils.formatDate(singleOrder.createdAt),
                fontSize: 14.0,
                color: const Color(0xFF7E8BA0),
              ),
              PrimaryButton(
                text: singleOrder.orderStatus,
                onPressed: () {},
                fontSize: 15.0,
                bgColor: singleOrder.orderStatus == 'expired'
                    ? redColor
                    : greenColor,
                borderRadiusSize: 3.0,
                minimumSize: Size(64.0.w, 36.0.h),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextStyle(
                text: singleOrder.planName,
                fontSize: 18.0,
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
              CustomTextStyle(
                text: Utils.formatPrice(context, singleOrder.planPrice),
                fontSize: 15.0,
                color: blackColor,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
          SizedBox(height: 16.0.h),
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  splashFactory: NoSplash.splashFactory,
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: borderRadius)),
                  minimumSize: MaterialStateProperty.all(
                      Size(double.infinity.w, 50.0.h))),
              onPressed: () => Navigator.pushNamed(
                  context, RouteNames.purchaseDetailsScreen,
                  arguments: singleOrder.orderId),
              icon: const Icon(
                Icons.visibility,
                size: 20.0,
              ),
              label: const CustomTextStyle(
                text: 'View Details',
                fontSize: 15.0,
                color: whiteColor,
              ))
        ],
      ),
    );
  }
}
