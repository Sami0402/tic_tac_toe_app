class Room {
  String? sId;
  String? roomCode;
  String? host;
  String? hostUsername;
  String? guest;
  String? guestUsername;
  String? hostSymbol;
  String? guestSymbol;
  int? hostScore;
  int? guestScore;
  String? currentTurn;
  String? status;
  String? winner;
  List<dynamic>? winningCombination;
  List<String>? board;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Room(
      {this.sId,
      this.roomCode,
      this.host,
      this.hostUsername,
      this.guest,
      this.guestUsername,
      this.hostSymbol,
      this.guestSymbol,
      this.hostScore,
      this.guestScore,
      this.currentTurn,
      this.status,
      this.winner,
      this.winningCombination,
      this.board,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Room.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomCode = json['roomCode'];
    host = json['host'];
    hostUsername = json['hostUsername'];
    guest = json['guest'];
    guestUsername = json['guestUsername'];
    hostSymbol = json['hostSymbol'];
    guestSymbol = json['guestSymbol'];
    hostScore = json['hostScore'];
    guestScore = json['guestScore'];
    currentTurn = json['currentTurn'];
    status = json['status'];
    winner = json['winner'];
    winningCombination = json['winningCombination'];
    board = json['board'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['roomCode'] = this.roomCode;
    data['host'] = this.host;
    data['hostUsername'] = this.hostUsername;
    data['guest'] = this.guest;
    data['guestUsername'] = this.guestUsername;
    data['hostSymbol'] = this.hostSymbol;
    data['guestSymbol'] = this.guestSymbol;
    data['hostScore'] = this.hostScore;
    data['guestScore'] = this.guestScore;
    data['currentTurn'] = this.currentTurn;
    data['status'] = this.status;
    data['winner'] = this.winner;
    data['winningCombination'] = this.winningCombination;
    data['board'] = this.board;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
