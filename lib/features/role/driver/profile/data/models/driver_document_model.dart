import 'package:flutter/material.dart';

class DriverDocumentItem {
  final String id;
  final String title;
  final IconData icon;
  String status; // 'Approved', 'Not Submitted', 'Pending Review'
  final String documentNumber;
  final String issuedBy;
  final String issueDate;
  final String expiryDate;
  final String holderName;
  String? imagePath;
  final String description;
  final bool isOptional;

  DriverDocumentItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.status,
    required this.documentNumber,
    required this.issuedBy,
    required this.issueDate,
    required this.expiryDate,
    required this.holderName,
    this.imagePath,
    required this.description,
    this.isOptional = false,
  });

  bool get isApproved => status.toLowerCase() == 'approved';
  bool get isNotSubmitted => status.toLowerCase() == 'not submitted';
  bool get isPending => status.toLowerCase() == 'pending review';
}
