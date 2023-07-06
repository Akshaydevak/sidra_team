// ignore_for_file: prefer_final_fields, avoid_single_cascade_in_expression_statements

import 'dart:convert';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Authentication {
  static final _singleton = Authentication._internal();

  factory Authentication() {
    return _singleton;
  }

  Authentication._internal();

  String _keyAuthenticatedUser = "keyAuthenticated";
  String _keyAuthenticatedToken = "keyAuthenticatedToken";
  String keyAdmin = "keyAdmin";
  bool _isAdmin=false;
  bool get isAdmin=>_isAdmin;
  User _authenticatedUser = User();
  User get authenticatedUser => _authenticatedUser;
  List<User>? _authenticatedTokenData;
  List<User>? get authenticatedTokenData => _authenticatedTokenData;
  bool get isAuthenticated => _authenticatedUser.token != null;
  // bool get isAdmin{
  //   if(authenticatedUser.roleList!=null && authenticatedUser.roleList!.isNotEmpty)
  //   for(var i =0;i<authenticatedUser.roleList!.length;i++){
  //     authenticatedUser.roleList?[i]=="admin"?isAdmin=true:

  //   }
  //   return true;
  // }


  // String get token => _authenticatedUser.customerCode ?? "";
  // List<String> get searchWord => _authenticatedUser.searchedWord ?? [];
  Future<void> init() async {
    print("before   retrieve cache data");

    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      String? authenticatedUserJsonString =
      sharedPreferences.getString(_keyAuthenticatedUser);
      bool? authenticatedAdmin =
      sharedPreferences.getBool(keyAdmin);
      if (authenticatedUserJsonString != null) {
        print("retrieve cache data");
        _authenticatedUser = User.fromJson(
          jsonDecode(authenticatedUserJsonString),
        );
      }

      if (authenticatedAdmin != null) {
        print("debug issue found inbetween ater user  ullil ethiii");
        _isAdmin = authenticatedAdmin;
        print("debug issue found inbetween ater user adminnnnn ${_isAdmin}");
      }
      String? authenticatedTokenJsonString =
      sharedPreferences.getString(_keyAuthenticatedToken);
      //  String? authenticatedTokenJsonString =
      //       sharedPreferences.getString(_keyAuthenticatedToken);

      if (authenticatedTokenJsonString != null) {
        print("debug issue found");
        authenticatedTokenData?.add(User.fromJson(jsonDecode(authenticatedTokenJsonString)));
        // for (var element in (authenticatedTokenJsonString as List)) {
        //   _authenticatedTokenData!.add(User.fromJson(jsonDecode(authenticatedTokenJsonString)));
        // }
        print("debug issue found inbetween${authenticatedTokenData?.length}");
      }
    } catch (e) {
      debugPrint("Authentication:init:Exception:$e");
    }
  }

  Future<void> saveAuthenticatedUser({
    bool? isAdmin,
    required User authenticatedUser,
  }) async {
    try {
      // if (condition) {

      // }
      _authenticatedUser = authenticatedUser;
      _isAdmin=isAdmin??false;
      await SharedPreferences.getInstance()
        ..setBool(
          keyAdmin,
          isAdmin??false,
        );
      print("anganene admin val = $isAdmin");

      if (authenticatedUser.token!.isNotEmpty) {
        print("enteredddd savingg!!!");
        // ignore: avoid_single_cascade_in_expression_statements
        await SharedPreferences.getInstance()
          ..setString(
            _keyAuthenticatedUser,
            jsonEncode(_authenticatedUser.toJson()),
          );
        print("enteredddd savingg!!!");
      }
    } catch (e) {
      debugPrint("Authentication:saveAuthenticatedUser:Exception:$e");
    }
  }

  Future<void> saveAuthenticatedToken(
      {required List<User> authenticatedTokenData}) async {
    try {
      _authenticatedTokenData = authenticatedTokenData;

      if (authenticatedTokenData[0].token!.isNotEmpty) {
        for (int i = 0; i < authenticatedTokenData.length; i++) {
          await SharedPreferences.getInstance()
            ..setString(_keyAuthenticatedToken,
                jsonEncode(_authenticatedTokenData![i].toJson()));
        }

        for (int i = 0; i < authenticatedTokenData.length; i++) {
          print("debug issue token list !!!!${authenticatedTokenData[i].token}");
        }
      }
      print("debug issue token list !!!!$authenticatedTokenData");

    } catch (e) {
      debugPrint("Authentication:saveAuthenticatedUser:Exception:$e");
    }
  }

  // Future<void> clearAuthenticatedUser() async {
  //   try {
  //     _authenticatedUser = User();
  //
  //     await SharedPreferences.getInstance()
  //       ..remove(_keyAuthenticatedUser)
  //       ..clear();
  //
  //     // ignore: avoid_single_cascade_in_expression_statements
  //     await SharedPreferences.getInstance()
  //       ..remove(token);
  //   } catch (e) {
  //     debugPrint(
  //       "Authentication:clearAuthenticatedUser:Exception:$e",
  //     );
  //   }
  // }

  Future<void> clearAuthenticatedTokens() async {
    try {
      List<User> _authenticatedTokens = [];
      await SharedPreferences.getInstance()
        ..remove(_keyAuthenticatedToken)
        ..clear();
    } catch (e) {
      debugPrint(
        "Authentication:clearAuthenticatedUser:Exception:$e",
      );
    }
  }
}

final authentication = Authentication();