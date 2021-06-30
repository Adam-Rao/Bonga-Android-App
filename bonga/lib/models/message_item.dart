class MessageItem {
  late int _unreadMessages;
  late String _messageAuthor;
  late String _messageBody;
  late String _messageAuthorImageURL;

  MessageItem(
    this._unreadMessages,
    this._messageAuthor,
    this._messageBody,
    this._messageAuthorImageURL,
  );

  int get getUnreadMessages => this._unreadMessages;
  String get getMessageAuthor => this._messageAuthor;
  String get getMessageBody => this._messageBody;
  String get getMessageAuthorImageURL => this._messageAuthorImageURL;
}
