
// class GetNumber extends StatefulWidget {
//   const GetNumber({super.key});

//   @override
//   State<GetNumber> createState() => _GetNumberState();
// }

// class _GetNumberState extends State<GetNumber> {

//   String _mobileNumber = '';
//   List<SimCard> _simCard = <SimCard>[];

//   @override
//   void initState() {
//     super.initState();
//     MobileNumber.listenPhonePermission((isPermissionGranted) {
//       if (isPermissionGranted) {
//         initMobileNumberState();
//       } else {}
//     });

//     initMobileNumberState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initMobileNumberState() async {
//     if (!await MobileNumber.hasPhonePermission) {
//       await MobileNumber.requestPhonePermission;
//       return;
//     }
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       _mobileNumber = (await MobileNumber.mobileNumber)!;
//       _simCard = (await MobileNumber.getSimCards)!;
//     } on PlatformException catch (e) {
//       debugPrint("Failed to get mobile number because of '${e.message}'");
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {});
//   }

//   Widget fillCards() {
//     List<Widget> widgets = _simCard
//         .map((SimCard sim) => Text(
//             'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
//         .toList();
//     return Column(children: widgets);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Text('Running on: $_mobileNumber\n'),
//               // fillCards(),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: _simCard.length,
//                   itemBuilder: (context, index) {
//                     log("${_simCard.length}");
//                     return Column(
//                       children: [
//                         const SizedBox(
//                           height: 50,
//                         ),
//                         Text("number  ${_simCard[index].number}"),
//                         Text("displayName  ${_simCard[index].displayName}"),
//                         Text("slotIndex  ${_simCard[index].slotIndex}"),
//                         Text(
//                             "countryPhonePrefix  ${_simCard[index].countryPhonePrefix}"),
//                         Text("carrierName  ${_simCard[index].carrierName}"),
//                         Text("countryIso  ${_simCard[index].countryIso}"),
//                         const SizedBox(
//                           height: 50,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class GetMobileNumber {
  Future<String?> getMobileNumber() async {
    // Check if the user has granted permission to access their phone number.
    if (!await MobileNumber.hasPhonePermission) {
      // Request permission to access the user's phone number.
      await MobileNumber.requestPhonePermission;
    }

    // Get the mobile number from the device.
    try {
      return (await MobileNumber.mobileNumber)!;
    } on PlatformException catch (e) {
      // If there is an error getting the mobile number, print the error message.
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the mobile number could not be obtained, return null.
    return null;
  }
  Future<String?> getMobileNumberFromMobile() async {
    String? mobileNumber1 = await getMobileNumber();
    log("sdfsfdsfd  ${mobileNumber1?.substring(mobileNumber1.length - 10)}");
      return mobileNumber1?.substring(mobileNumber1.length - 10);
   
  }
}

  
