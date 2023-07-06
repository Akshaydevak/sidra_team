class OrderAppUrls{
  static const cartCheckoutBaseUrl = "https://api-uat-cart-checkout.sidrabazar.com/";
  static const orderManagementBaseUrl = "https://api-uat-order-management.sidrabusiness.com/";
  static const orderListUrl = "${cartCheckoutBaseUrl}order/Order_list?state=Initiated";
  static const pickListUrl = "${orderManagementBaseUrl}order-process/order-process-list/picking";
  static const packListUrl = "${orderManagementBaseUrl}order-process/order-process-list/packing";
  static const assignListUrl = "${orderManagementBaseUrl}order-process/order-process-list/assign";
  static const createPickingUrl = "${orderManagementBaseUrl}order-process/create-picklist";
  static const createPackingUrl= "${orderManagementBaseUrl}order-process/order-process-items/picking";
  static const createAssignmentUrl= "${orderManagementBaseUrl}order-process/order-process-items/packing";
  static const assignToPartnerUrl= "${orderManagementBaseUrl}order-process/order-process-items/assign";
  static const employeeListUrl = "https://api-uat-user.sidrabazar.com/user-employee_admin-list?acess_site=logisticapp";

}                                                                         