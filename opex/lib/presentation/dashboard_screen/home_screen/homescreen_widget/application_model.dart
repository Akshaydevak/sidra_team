
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';

class ApplicationModel {
  String name,icon;


  ApplicationModel({required this.name,required this.icon});
}

List<ApplicationModel> applicationList = [
  ApplicationModel(name: 'Task & Operation',icon: "asset/app_icon/task.png"),
  ApplicationModel(name: 'Chat App',icon: "asset/app_icon/chat.png"),
  // ApplicationModel(name: 'Order Mgt',icon: AppsSvg().OrderManagementIcon),
  //
  // ApplicationModel(name: 'MPOS',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Inventory',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Promotion app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Seller app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Seller Admin',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Logistic app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Sales app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Purchase app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Product Hub',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'User',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Delivery app',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Call center',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Self check',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Organisation',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Contract',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Tax',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Loyality',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Vendor',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Stock',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Manufacture',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Payments',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Wallet',icon: AppsSvg().OrderManagementIcon),
  // ApplicationModel(name: 'Settings',icon: AppsSvg().OrderManagementIcon),


];