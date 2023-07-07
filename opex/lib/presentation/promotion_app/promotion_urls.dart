class PromotionUrls{
  static const promotionSaleBaseUrl=
      "https://rgc-promotion.hilalcart.com/";
      // "https://api-uat-promotion.sidrabusiness.com/";


  //PROMOTION
  static const channelListUrl="https://api-uat-organization.sidrabusiness.com/channel/list-channel?business_unit=";
  static const segmentsPromotionUrl="https://api-uat-inventory.sidrabazar.com/display/list-segments";

  static const createOfferPeriodUrl="${promotionSaleBaseUrl}discount/create-offer-period";
  static const listOfferPeriodUrl="${promotionSaleBaseUrl}discount/list-offer-period";
  static const offerPeriodRead="${promotionSaleBaseUrl}discount/read-patch-delete-offer-period/";
  static const imageUploadDiscount="${promotionSaleBaseUrl}discount/upload-image";
  static const createOfferGroupUrl="${promotionSaleBaseUrl}discount/create-offer-group";
  static const listOfferGroupListUrl="${promotionSaleBaseUrl}discount/list-offer-group-for-discount/";
  static const offerGroupReadListUrl="${promotionSaleBaseUrl}discount/read-patch-delete-offer-group/";
  static const discountCreateUrl="${promotionSaleBaseUrl}discount/create-discount";
  static const typeAppliyingPostUrl="https://api-uat-inventory.sidrabazar.com/inventory-product/list-promotion-applying-on";
  static const productListUrl="https://api-uat-inventory.sidrabazar.com/inventory-product/list-variant-by-applying-on";
  static const customerGroupListUrl="https://api-customergroup-application.hilalcart.com";
  static const listDiscountUrl="${promotionSaleBaseUrl}discount/list-discount/";
  static const discountReadUrl="${promotionSaleBaseUrl}discount/read-patch-delete-discount/";
  static const listSelectedVariantsUrl="${promotionSaleBaseUrl}discount/list-products-by-group-code/";
  static const deactivatePromotionUrl="${promotionSaleBaseUrl}buy-more/deactivate-previous-offer-by-type";
  static const allvariantDeactivateUrl="${promotionSaleBaseUrl}buy-more/show-variants-to-deactivate";
  static const deleteSelectiveUrl="${promotionSaleBaseUrl}buy-more/deactivate-previous-offer-by-variant";

  /////BUYMORE/////

static const createBuyMoreUrl="${promotionSaleBaseUrl}buy-more/create-buy-more";
static const listBuyMoreUrl="${promotionSaleBaseUrl}buy-more/list-buy-more-by-inventory/";
static const readBuyMoreUrl="${promotionSaleBaseUrl}buy-more/read-buy-more/";

///Coupon API/////
static const createCouponUrl="${promotionSaleBaseUrl}coupon/create-coupon";
static const listCouponListUrl="${promotionSaleBaseUrl}coupon/list-coupon-by-inventory/";
static const readCouponUrl="${promotionSaleBaseUrl}coupon/read-patch-coupon/";
static const deactivateCouponPromotionUrl="${promotionSaleBaseUrl}coupon/deactivate-previous-coupon-by-type";
static const allVariantsUrlCoupon="${promotionSaleBaseUrl}coupon/show-variants-to-deactivate";

//negotiation

static const createNegotiationUrl="${promotionSaleBaseUrl}negotiation/create-negotiation";
static const listNegotiationUrl="${promotionSaleBaseUrl}negotiation/list-negotiation";
static const readNegotiationUrl="${promotionSaleBaseUrl}negotiation/read-patch-negotiation/";
}