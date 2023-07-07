class InventoryUrls {
  // static const baseUrl = "https://api-uat-inventory.sidrabazar.com/";
  static const baseUrl = "https://api-rgc-inventory.hilalcart.com/";
  static const divisionUrl = "${baseUrl}product-admin/list-division";
  static const categoryUrl =
      "${baseUrl}product-admin/list-category-by-division/";
  static const subCategoryUrl =
      "${baseUrl}product-admin/list-sub-category-by-parent/";
  static const groupUrl = "${baseUrl}product-admin/list-group-by-category/";
  static const itemUrl = "${baseUrl}product-admin/list-item-by-group/";
  static const uomUrl = "${baseUrl}product-admin/list-uom-group";
  static const saleUomUrl = "${baseUrl}product-admin/list-sales-uom-by-base-uom/";
  // static const saleUomUrl = "${baseUrl}product-admin/list-uom-by-uom-grp/";
  static const pictureUrl = "${baseUrl}product-admin/upload-image";
  static const variantUrl = "${baseUrl}product-admin/list-variant-by-item/";
  static const combinationUrl = "${baseUrl}product-admin/list-framework-lines-by-framework/";
  static const channelUrl = "https://api-uat-organization.sidrabusiness.com/channel/list-channel?business_unit=";
  static const createVariantUrl = "${baseUrl}product-admin/create-new-variant";
  // static const manufactureUrl = "https://api-uat-user.sidrabazar.com/user-manufacturer_manufactureruserlist";
  static const manufactureUrl = "https://api-rgc-user.hilalcart.com/user-manufacturer_manufactureruserlist";
  static const siblingUrl = "https://api-rgc-inventory.hilalcart.com/product-admin/list-variants-by-inventory/";
  static const inventoryDataUrl = "https://api-uat-organization.sidrabusiness.com/legalunit/business-unit-list?business_unit_code=";
  static const listVariantsUrl = "${baseUrl}product-admin/list-variants-by-inventory/";
  static const readVariantsUrl = "${baseUrl}product-admin/read-variant/";
  static const updateVariantsUrl = "${baseUrl}product-admin/edit-variant/";
  static const deleteVariantsUrl = "${baseUrl}product-admin/delete-variant/";
  static const stockPartitionUrl = "${baseUrl}product-admin/list-partition-stock-groups-by-inventory/";
  //inventory Id pass cheyyanm
  //Stock
  static const productStocklistUrl="${baseUrl}product-admin/list-variants-by-inventory/";
  static const readStockUrl="${baseUrl}product-admin/read-variant-for-stock/";
  static const createStockUrl="${baseUrl}product-admin/create-stock";
  static const createCostMethodTypeUrl="${baseUrl}product-admin/costing-method-type-create";
  static const costMethodTypeListUrl="${baseUrl}product-admin/list-costing-method-type";
  static const costMethodTypeReadUrl="${baseUrl}product-admin/read-patch-costing-method-type/";

  static const createcostMethodUrl="${baseUrl}product-admin/costing-method-create";
  static const costingmethodListUrl="${baseUrl}product-admin/list-costing-method";
  static const costingMethodReadUrl="${baseUrl}product-admin/read-patch-costing-method/";

  static const createPricingTypeUrl="${baseUrl}product-admin/pricing-type-create";
  static const pricingTypeListUrl="${baseUrl}product-admin/list-pricing-type";
  static const readPricingTypeUrl="${baseUrl}product-admin/pricing-type-read-update/";

  static const createPricingGroupUrl="${baseUrl}product-admin/pricing-group-create";
  static const pricinggroupListUrl="${baseUrl}product-admin/list-pricing-groups";
  static const readPricingGroupUrl="${baseUrl}product-admin/pricing-group-read-update/";

  static const readCostingByVariant="${baseUrl}product-admin/get-variant-details-for-costing/";
  static const GPPostUrl="${baseUrl}product-admin/get-percentage-by-choice";

  static const createCostingUrl="${baseUrl}product-admin/create-costing";
  static const costingListUrl="${baseUrl}product-admin/list-costing-by-variant/";
  static const readCostingUrl="${baseUrl}product-admin/read-costing/";
  static const patchCostingUrl="${baseUrl}product-admin/patch-costing/";

  static const createDivisionUrl="${baseUrl}product-admin/create-division";
  static const readDivisionUrl="${baseUrl}product-admin/patch-division/";

  static const createCategoryUrl="${baseUrl}product-admin/create-category";
  static const readCategoryUrl="${baseUrl}product-admin/patch-category/";
  static const listCategoryUrl="${baseUrl}product-admin/list-category";

  static const createGroupUrl="${baseUrl}product-admin/create-group";
  static const readGroupUrl="${baseUrl}product-admin/patch-group/";
  static const listGroupUrl="${baseUrl}product-admin/list-group";

  static const createUomGroupUrl="${baseUrl}product-admin/create-uom-group";
  static const readUomGroupurl="${baseUrl}product-admin/patch-uom-group/";
  static const listUomgroupUrl="${baseUrl}product-admin/list-uom-group";

  static const createUomUrl="${baseUrl}product-admin/create-uom";
  static const readUomUrl="${baseUrl}product-admin/patch-uom/";
  static const listUomUrl="${baseUrl}product-admin/list-uom";

  static const createMaterialUrl="${baseUrl}product-admin/create-material";
  static const readMaterialUrl="${baseUrl}product-admin/patch-material/";
  static const listMaterialUrl="${baseUrl}product-admin/list-material";


  static const createStaticGroupUrl="${baseUrl}product-admin/create-static-group";
  static const readStaticGroupUrl="${baseUrl}product-admin/patch-static-group/";
  static const listStaticGroupUrl="${baseUrl}product-admin/list-static-group";

  static const createBrandUrl="${baseUrl}product-admin/create-brand";
  static const readBrandUrl="${baseUrl}product-admin/patch-brand/";
  static const listBrandUrl="${baseUrl}product-admin/list-brand";

  static const createAttributeUrl="${baseUrl}product-admin/create-attribute";
  static const listAttributeUrl="${baseUrl}product-admin/list-attribute";
  static const readAttributeUrl="${baseUrl}product-admin/read-patch-attribute/";

  static const createVarientFrameworkUrl="${baseUrl}product-admin/create-variant-framework";
  static const listVarientFrameworkUrl="${baseUrl}product-admin/list-variant-framework";
  static const readVariantFrameworkUrl="${baseUrl}product-admin/read-patch-variantframework/";

  static const createItemUrl="${baseUrl}product-admin/create-item";
  static const readItemUrl="${baseUrl}product-admin/read-patch-item/";
  static const listItemUrl="${baseUrl}product-admin/list-item";

  static const listgroupforDivisionAllocationUrl="${baseUrl}product-admin/list-group-for-division-configuration";
  static const listCategoryforDivisionAllocationUrl="${baseUrl}product-admin/list-category-for-division-configuration";
  static const listUomforDivisionAllocationUrl="${baseUrl}product-admin/list-uom-for-division-configuration";

  static const createDivisionConfigUrl="${baseUrl}product-admin/create-division-configuration";
  static const listdivisionConfigUrl="${baseUrl}product-admin/list-division-configuration";
  static const readDivisionConfigUrl="${baseUrl}product-admin/patch-division-configuration/";

  static const createWarrantyTypeUrl="${baseUrl}warranty/create-warranty-type";
  static const listWarrantyTypeUrl="${baseUrl}warranty/list-warranty-type";
  static const readWarrantyTypeUrl="${baseUrl}warranty/read-patch-warranty-type/";

  static const createWarrantyUrl="${baseUrl}warranty/create-warranty";
  static const readWarrantyUrl="${baseUrl}warranty/read-warranty/";
  static const deleteWarrantyUrl="${baseUrl}warranty/delete-warranty/";
  static const listWarrantyUrl="${baseUrl}warranty/list-warranty-by-variant/";

  static const uomByUomGroupUrl="${baseUrl}product-admin/list-uom-by-uom-grp/";
}
