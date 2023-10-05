import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulearning_app/common/entities/entities.dart';

import '../values/constant.dart';

class StorageService{

  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }


  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  bool getDeviceFirstOpen(){
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME)??false;
  }

  bool getIsLoggedIn(){
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY)==null?false:true;
  }

  UserItem? getUserProfile(){
    var profileOffline = _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY)??"";
    print(profileOffline);
    if(profileOffline.isNotEmpty){
      return UserItem.fromJson(jsonDecode(profileOffline));
    }
    return null;
  }

  String getUserToken(){
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }
}