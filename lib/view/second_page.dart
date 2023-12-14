import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_sim_number/service/coupon_data_model.dart';
import 'package:get_sim_number/service/service.dart';
import 'package:get_sim_number/view/qr_code_widget.dart';

class ShowCoupon extends StatefulWidget {
  const ShowCoupon({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);
  final String? mobileNumber;
  @override
  State<ShowCoupon> createState() => _ShowCouponState();
}

class _ShowCouponState extends State<ShowCoupon> {
  @override
  void initState() {
    super.initState();
    fetchHomeData();
  }

  // Map<String, String> qrData = {};
  // void qrDatafun() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString("qrValue");
  // }

  // Map<String, dynamic>? qrData = {};
  List<Responsecoupon> couponList = [];
  bool isloading = false;
  fetchHomeData() async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // setState(() {
    //   qrData = jsonDecode(pref.getString("qrValue").toString());
    //   log(qrData.toString());
    // });
    setState(() {
      isloading = true;
    });
    List<Responsecoupon> _couponList = await QRservice()
        .getCoupons(mobileNumber: widget.mobileNumber, context: context);

    setState(() {
      couponList = _couponList;
    });
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Idly Vada Sambar"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Builder(builder: (context) {
        if (couponList.isEmpty) {
          return const Center(
            child: Text("No Coupon Found"),
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your Coupons",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: couponList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      Map<String, String> data = {
                        "user_id": couponList[index].userid ?? "na",
                        "mobileNumber": couponList[index].mobile ?? "na",
                        "Offer": couponList[index].offerdata ?? "na",
                      };
                      return GestureDetector(
                        onTap: () {
                          showQRPopup(
                            context: context,
                            data: data.toString(),
                            offer: couponList[index].offerdata ?? "na",
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: buildQrCode(
                                        context: context,
                                        data: jsonEncode(data)),
                                  )),
                              Expanded(
                                flex: 1,
                                child:
                                    Text(couponList[index].offerdata ?? "na"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
