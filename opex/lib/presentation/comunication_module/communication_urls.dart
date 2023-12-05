class CommunicationUrls {
  static const communicationBaseUrl =
      "https://api-communication-application.hilalcart.com/"
      // "https://6af7-116-68-110-250.ngrok-free.app/"
     
      ;

  static const getAllRegisteredUsersUrl="${communicationBaseUrl}api/chat/users/list";
  static const addAFriendUser="${communicationBaseUrl}api/inventory/inventory-connect-personal";
  static const createGroupUrl="${communicationBaseUrl}api/inventory/inventory-connect-group";
  static const leaveGroupUrl="${communicationBaseUrl}api/chat/leave/group";
  static const getChatList="${communicationBaseUrl}api/chat/";
  static const getFilteredChatList="${communicationBaseUrl}api/chat?query=";
  static const getChatScreenUrl="${communicationBaseUrl}api/chat/messages/";
  static const getGroupProfileDetailsUrl="${communicationBaseUrl}api/chat/user/profile/";
  static const getGroupAttachmentsInProfileUrl="${communicationBaseUrl}api/chat/details/group/";
  static const tokenCreationCommunicationUrl="${communicationBaseUrl}api/inventory/inventory-login";
  //image upload
  static const uploadImageUrl="https://api-uat-user.sidrabazar.com/file-upload";
  //inventory related
  static const sidraBazarBaseUrl="https://api-uat-user.sidrabazar.com/";
  static const getAllRegisteredUsersInInventory="${sidraBazarBaseUrl}user-employee_employeeuser";
  static const searchUser = "${sidraBazarBaseUrl}user-employee_employeeuser?search_key=";

}
