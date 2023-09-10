class SellerAdminUrls {

  // static const baseUrl="https://api-rgc-organization.hilalcart.com/";
  // static const userBaseUrl="https://api-rgc-user.hilalcart.com/";
  // static const cartCheckoutBaseUrl="https://api-rgc-cartcheckout.hilalcart.com/";
  //
  static const baseUrl="https://api-uat-organization.sidrabusiness.com/";
  static const userBaseUrl="https://api-uat-user.sidrabazar.com/";
  static const cartCheckoutBaseUrl="https://api-uat-cart-checkout.sidrabazar.com/";


  static const categoryListSellerUrl="${baseUrl}category-list";
  static const sellerListUrl="${baseUrl}legalunit/legalunit-list/min";
  static const createSellerUrl="${baseUrl}legalunit/create-legalunit";
  static const createOutletUrl="${baseUrl}legalunit/business-unit-create/";
  static const businessOutletListUrl="${baseUrl}legalunit/business-unit-list?company_code=";
  static const readSellersUrl="${baseUrl}legalunit/legalunit-update/";
  static const readOutletUrl="${baseUrl}legalunit/business-unit-update/";
  static const updateOrganisationUrl="${baseUrl}legalunit/legalunit-update/org/";
  static const officialRoleListUrl="${userBaseUrl}user-general_role?role_type=designation_role";
  static const additionalRoleListUrl="${userBaseUrl}user-general_role?role_type=additional_roles";
  static const userVerifyListUrl="${userBaseUrl}partner_partnerurer/list/verify";
  static const verfyUserUrl="${userBaseUrl}partner_partnerurer/verify/";
  static const departmentListUrl="${baseUrl}operation-unit/list-operation-unit";
  static const designationListUrl="${baseUrl}legalunit/";
  static const createDesignationUrl="${baseUrl}legalunit/";
  static const createUser="${userBaseUrl}user-employee_admin-add?acess_site=clusterstar&";
  static const employeeUserListUrl="${userBaseUrl}user-employee_employeeuser";
  static const directorUserListUrl="${userBaseUrl}user-director_list/admin";
  static const countryListUrl="https://api-uat-user.sidrabazar.com/country-list?value=list";
  static const stateListUrl="https://api-uat-user.sidrabazar.com/state-list?code=";
  static const profileUpdateSellerUrl="${baseUrl}legalunit/legal-unit-logo-update/";
  static const readBusinessDetailsUrl="${baseUrl}legalunit/legalunit-list/org";
  static const sellerAdminDashboardUrl="${baseUrl}partner-overview";
  static const sellerAdminViewDashboardUrl="${cartCheckoutBaseUrl}order/order-statics/super-admin";
}