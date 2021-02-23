import 'package:flutter/material.dart';

@immutable
class InitialAtr {
  final String userId;
  final String atrDocumentId;
  final bool isComplete;

  InitialAtr({
    @required this.userId,
    this.atrDocumentId,
    this.isComplete = false,
  });

  factory InitialAtr.fromJSON(Map<String, dynamic> json, String atrId) {
    return InitialAtr(
      userId: json['userId'],
      isComplete: json['isComplete'],
      atrDocumentId: atrId,
    );
  }

  Map<String, dynamic> toJSON() => {
        'userId': userId,
        'isComplete': isComplete,
      };

  @override
  int get hashCode => userId.hashCode ^ isComplete.hashCode;

  @override
  bool operator ==(other) {
    return (other is InitialAtr) &&
        other.userId == userId &&
        other.isComplete == isComplete;
  }
}
