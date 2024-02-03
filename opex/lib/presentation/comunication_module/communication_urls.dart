class CommunicationUrls {
  static const communicationBaseUrl =
      "https://api-communication-application.hilalcart.com/";
      // "http://192.168.1.187:5500/";
      // "https://8120-223-228-161-250.ngrok-free.app/";

  static const getAllRegisteredUsersUrl="${communicationBaseUrl}api/chat/users/list";
  static const addAFriendUser="${communicationBaseUrl}api/inventory/inventory-connect-personal";
  static const createGroupUrl="${communicationBaseUrl}api/inventory/inventory-connect-group";
  static const commentGroupUrl="${communicationBaseUrl}api/group/group-messages/";
  static const leaveGroupUrl="${communicationBaseUrl}api/chat/leave/group";
  static const getChatList="${communicationBaseUrl}api/chat/";
  static const getFilteredChatList="${communicationBaseUrl}api/chat?query=";
  static const getChatScreenUrl="${communicationBaseUrl}api/chat/messages/";
  static const getGroupProfileDetailsUrl="${communicationBaseUrl}api/chat/user/profile/";
  static const getGroupAttachmentsInProfileUrl="${communicationBaseUrl}api/chat/details/group/";
  static const tokenCreationCommunicationUrl="${communicationBaseUrl}api/inventory/inventory-login";
  static const addGroupMember="${communicationBaseUrl}api/inventory/inventory-add-member/";
  static const deleteGroupMember="${communicationBaseUrl}api/inventory/inventory-delete-member/";
  //image upload
  static const uploadImageUrl="https://api-uat-user.sidrabazar.com/file-upload";
  //inventory related
  static const sidraBazarBaseUrl="https://api-uat-user.sidrabazar.com/";
  static const getAllRegisteredUsersInInventory="${sidraBazarBaseUrl}user-employee_employeeuser";
  static const searchUser = "${sidraBazarBaseUrl}user-employee_employeeuser?search_key=";

}
