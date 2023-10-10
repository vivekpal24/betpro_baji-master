import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/response/payment_gateway_model.dart';
import 'package:getx_skeleton/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class DepositScreenController extends GetxController {
  PaymentGatewayModel paymentGatewayModel = PaymentGatewayModel();
  var gateways = <Gateways>[].obs;
  ApiCallStatus apiCallStatus = ApiCallStatus.loading;
  var selectedIndex = 0.obs;
  TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    getGateways();
    super.onInit();
  }

  getGateways() async {
    String token = MySharedPref.getData('token') ?? '';
    // *) perform api call
    await BaseClient.safeApiCall(
      Constants.gatewayApiUrl, // url
      RequestType.get, // request type (get,post,delete,put)
      headers: {'Authorization': 'Bearer $token'},
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        print(token);
        // api done successfully
        paymentGatewayModel = PaymentGatewayModel.fromJson(response.data);
        paymentGatewayModel.gateways!.forEach((element) {
          if (element.name == "PayPal" || element.name == "Stripe") {
            gateways.add(element);
          }
        });
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  sendDeposit() async {
    String token = MySharedPref.getData('token') ?? '';
    // *) perform api call
    await BaseClient.safeApiCall(
      Constants.depositApiUrl, // url
      RequestType.post, // request type (get,post,delete,put)
      headers: {'Authorization': 'Bearer $token'},
      data: {
        'gateway_id': gateways[selectedIndex.value].id.toString(),
        'amount': amountController.text
      },
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) async{
        // api done successfully
        final homeLogic = Get.find<DashboardScreenController>();
        await homeLogic.getProfile();
        Get.toNamed(Routes.HOME);
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  // Paypal payment
  handlePaypalPayment() {
    Get.to(UsePaypal(
        sandboxMode: true,
        clientId: gateways[selectedIndex.value].gatewayKeyOne ?? '',
        secretKey: gateways[selectedIndex.value].gatewayKeyTwo ?? '',
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: [
          {
            "amount": {
              "total": amountController.text,
              "currency": "USD",
              "details": {
                "subtotal": amountController.text,
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "Deposit at Betpro",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "Deposit at Betpro",
                  "quantity": 1,
                  "price": amountController.text,
                  "currency": "USD",
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          CustomSnackBar.showCustomErrorToast(message: "Deposited successfully");
          await sendDeposit();
        },
        onError: (error) {
          CustomSnackBar.showCustomErrorToast(message: "An Error occured");
          Get.toNamed(Routes.HOME);
        },
        onCancel: (params) {
          CustomSnackBar.showCustomErrorToast(message: "Payment Cancelled");
          Get.toNamed(Routes.HOME);
        }));
  }


  //Stripe Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': "USD",
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer ${gateways[selectedIndex.value].gatewayKeyOne}', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  handleStripePayment() async {
    try {
      //STEP 1: Create Payment Intent
      var paymentIntent = await createPaymentIntent((amountController.text.toInt() * 100).toString(), "USD");
      Stripe.publishableKey = gateways[selectedIndex.value].gatewayKeyTwo ?? '';
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: "Betpro"));

      //STEP 3: Display Payment sheet
      await Stripe.instance.presentPaymentSheet().then((value) async{
        CustomSnackBar.showCustomErrorToast(message: "Deposited successfully");
        await sendDeposit();
        paymentIntent = null;
      });
    } on StripeException catch (e) {
      CustomSnackBar.showCustomErrorToast(message: e.toString());
    }
  }
}
