import 'package:flutter/material.dart';

class HistoryRecord {
  final String title;
  final String userId;
  final String documentId;
  HistoryRecord({
    @required this.title,
    @required this.userId,
    this.documentId,
  });

  HistoryRecord.fromFirestore(Map<String, dynamic> data, String documentId)
      : title = data['title'],
        userId = data['userId'],
        documentId = documentId;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
    };
  }
}
