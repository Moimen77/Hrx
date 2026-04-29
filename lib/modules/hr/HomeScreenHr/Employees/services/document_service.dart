import 'dart:io';
import 'package:hrx/data/models/document_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentService {
  final _supabase = Supabase.instance.client;

  Future<List<DocumentModel>> getDocuments(int employeeId) async {
    final response = await _supabase
        .from('Documents')
        .select()
        .eq('user_id', employeeId)
        .order('created_at', ascending: false);

    return (response as List).map((e) => DocumentModel.fromJson(e)).toList();
  }

  Future<void> addDocument({
    required int employeeId,
    required String documentName,
    required File file,
    required String filePath,
  }) async {
    await _supabase.storage.from('Employees_Documents').upload(filePath, file);

    final documentUrl = _supabase.storage
        .from('Employees_Documents')
        .getPublicUrl(filePath);

    await _supabase.from('Documents').insert({
      'document_name': documentName,
      'user_id': employeeId,
      'document_url': documentUrl,
    });
  }

  Future<void> deleteDocument(int documentId, String documentUrl) async {
    // 1. Extract file path from URL
    final uri = Uri.parse(documentUrl);
    final filePath = uri.pathSegments
        .sublist(uri.pathSegments.indexOf('Employees_Documents') + 1)
        .join('/');

    // 2. Delete from storage
    await _supabase.storage.from('Employees_Documents').remove([filePath]);

    // 3. Delete from database
    await _supabase.from('Documents').delete().eq('id', documentId);
  }
}
