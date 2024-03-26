class CommunicationUrls {
  static const communicationBaseUrl =
      "https://api-communication-application.hilalcart.com/";
      // "https://test-1communication.hilalcart.com/";

      // "http://192.168.1.187:5500/";
      // "https://5z7l1nh4-5500.inc1.devtunnels.ms/";

  static const getAllRegisteredUsersUrl="${communicationBaseUrl}api/chat/users/list";
  static const addAFriendUser="${communicationBaseUrl}api/inventory/inventory-connect-personal";
  static const createGroupUrl="${communicationBaseUrl}api/inventory/inventory-connect-group";
  static const commentGroupUrl="${communicationBaseUrl}api/group/group-messages/";
  static const leaveGroupUrl="${communicationBaseUrl}api/chat/leave/group";
  static const getChatList="${communicationBaseUrl}api/chat/";
  static const getFilteredChatList="${communicationBaseUrl}api/chat?query=";
  static const getChatScreenUrl="${communicationBaseUrl}api/chat/messages/";
  static const getGroupProfileDetailsUrl="${communicationBaseUrl}api/chat/user/profile/";
  static const getGroupProfileDataUrl="${communicationBaseUrl}api/chat/group/update/";
  static const getGroupAttachmentsInProfileUrl="${communicationBaseUrl}api/chat/details/group/";
  static const tokenCreationCommunicationUrl="${communicationBaseUrl}api/inventory/inventory-login";
  static const addGroupMember="${communicationBaseUrl}api/inventory/inventory-add-member/";
  static const deleteGroupMember="${communicationBaseUrl}api/inventory/inventory-delete-member/";
  static const groupeditdetails="${communicationBaseUrl}api/inventory/inventory-group-update/";
  static const messagedelete="${communicationBaseUrl}api/chat/message/delete";
  //image upload
  static const uploadImageUrl="${communicationBaseUrl}api/upload/file-upload";
  static const uploadImagegroupUrl="https://api-uat-user.sidrabazar.com/file-upload/";
  //inventory related
  static const sidraBazarBaseUrl="https://api-uat-user.sidrabazar.com/";
  static const getAllRegisteredUsersInInventory="${sidraBazarBaseUrl}user-employee_employeeuser";
  static const searchUser = "${sidraBazarBaseUrl}user-employee_employeeuser?search_key=";

}
