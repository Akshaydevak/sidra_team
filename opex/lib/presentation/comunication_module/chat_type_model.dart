class ChatTypeModel {
  String name;
  String code;
  ChatTypeModel({required this.name, required this.code});
}

List<ChatTypeModel> chatTypeList = [
  ChatTypeModel(name: 'All Chats', code: ""),
  ChatTypeModel(name: 'Personal', code: "chats"),
  ChatTypeModel(name: 'Group Chat', code: "groups"),
];
