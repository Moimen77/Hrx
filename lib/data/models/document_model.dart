class DocumentModel {
  final int id;
  final String documentName;
  final int employeeId;
  final String documentUrl;
  final DateTime createdAt;

  DocumentModel({
    required this.id,
    required this.documentName,
    required this.employeeId,
    required this.documentUrl,
    required this.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      documentName: json['document_name'],
      employeeId: json['user_id'],
      documentUrl: json['document_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
