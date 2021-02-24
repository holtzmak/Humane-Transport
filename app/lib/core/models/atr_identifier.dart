import 'package:flutter/material.dart';

@immutable
class AtrIdentifier {
  final String userId;
  final String atrDocumentId;
  final bool isComplete;

  AtrIdentifier({
    @required this.userId,
    this.atrDocumentId,
    this.isComplete = false,
  });

  factory AtrIdentifier.fromJSON(
      Map<String, dynamic> json, String atrDocumentId) {
    return AtrIdentifier(
      userId: json['userId'],
      isComplete: json['isComplete'],
      atrDocumentId: atrDocumentId,
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
    return (other is AtrIdentifier) &&
        other.userId == userId &&
        other.isComplete == isComplete;
  }
}
