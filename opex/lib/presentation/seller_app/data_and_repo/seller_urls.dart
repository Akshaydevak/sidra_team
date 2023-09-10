class SellerUrls {

  static const baseUrl="https://api-rgc-cartcheckout.hilalcart.com/";
  // static const baseUrl="https://api-uat-cart-checkout.sidrabazar.com/";
  static const invBaseUrl="https://api-rgc-inventory.hilalcart.com/";
  // static const invBaseUrl="https://api-uat-inventory.sidrabazar.com/";
  //

  static const newOrdersSellerUrl="${baseUrl}order/Order_list";
  static const sellerListUrl="https://api-uat-organization.sidrabusiness.com/legalunit/user-all-business-list/";
  static const outOfStockListUrl="${invBaseUrl}product-admin/out-of-stock-variant-by-inventory/";
  static const dathboadUrl="https://api-uat-order-management.sidrabusiness.com/order-process/order-analytics";
  static const totalProductCountUrl="https://api-uat-inventory.sidrabazar.com/product-admin/get-products-quantity-by-inventory/";

  static const newlyAddedListUrl="${invBaseUrl}product-admin/get-newly-addedd-products-by-inventory/";
  static const topSellingListUrl="${invBaseUrl}product-admin/top-selling-product-by-inventory/";
  static const topReviewdListUrl="${invBaseUrl}product-admin/top-reviewed-product-by-inventory/";

}