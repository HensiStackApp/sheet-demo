class UserData {
  String email;
  String firstName;
  String lastName;
  String userID;
  String token;
  DateTime date;

  UserData({this.email, this.firstName, this.lastName, this.userID, this.date, this.token});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return new UserData(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        token: parsedJson['token'] ?? '',
        userID: parsedJson['userID'] ?? parsedJson['userID'] ?? '',
        date: parsedJson['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'token': this.token,
      'userID': this.userID,
      'date': DateTime.now(),
    };
  }
}

class ChatData {
  String msg;
  int type;
  String msgFrom;
  String msgTo;
  bool isOnline = false;
  bool seen = false;
  bool hasUnSeenMsg = true;
  String unseenCount;
  DateTime lastMsgTime;

  ChatData(
      {this.msg,
      this.type,
      this.msgFrom,
      this.msgTo,
      this.isOnline,
      this.seen,
      this.hasUnSeenMsg,
      this.unseenCount,
      this.lastMsgTime});

  factory ChatData.fromJson(Map<String, dynamic> parsedJson) {
    return new ChatData(
        msg: parsedJson['msg'] ?? '',
        type: parsedJson['type'] ?? '',
        msgFrom: parsedJson['msgFrom'] ?? '',
        msgTo: parsedJson['msgTo'] ?? '',
        isOnline: parsedJson['isOnline'] ?? '',
        seen: parsedJson['seen'] ?? '',
        hasUnSeenMsg: parsedJson['hasUnSeenMsg'],
        unseenCount: parsedJson['unseenCount'],
        lastMsgTime: parsedJson['lastMsgTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': this.msg,
      'type': this.type,
      'msgFrom': this.msgFrom,
      'msgTo': this.msgTo,
      'isOnline': this.isOnline,
      'seen': this.seen,
      'hasUnSeenMsg': this.hasUnSeenMsg,
      'unseenCount': this.unseenCount,
      'lastMsgTime': DateTime.now(),
    };
  }
}
