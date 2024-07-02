import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final decodedBody = jsonDecode(res.body);
            User user = (userProvider.user.copyWith(
              address: decodedBody['address'],
            ));
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          },
        ),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your Order has been placed");
            User user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

//get all the products

//deleteProduct
void deleteProduct({
  required BuildContext context,
  required Product product,
  required VoidCallback onSuccess,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/delete-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode(
        {'id': product.id},
      ),
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        onSuccess();
      },
    );
  } catch (e) {
    showSnackBar(
      context,
      e.toString(),
    );
  }
}
