class ChatReasonModel {
  final int id;
  final String reason;

  ChatReasonModel({required this.id, required this.reason});

  factory ChatReasonModel.fromJson(Map<String, dynamic> json) {
    return ChatReasonModel(
      id: json['id'],
      reason: json['reason'],
    );
  }
}
