import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:firedart/firedart.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.patch => _updateList(context, id),
    HttpMethod.delete => _deleteList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _updateList(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final description = body['description'] as String?;
  final status = body['status'] as String?;
  final listId = body['listId'] as String?;

  await Firestore.instance.collection('tasklists').document(id).update(
    {
      'name': name,
      'description': description,
      'status': status,
      'listId': listId,
    },
  );

  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteList(RequestContext context, String id) async {
  await Firestore.instance.collection('tasklists').document(id).delete().then(
    (value) {
      return Response(statusCode: HttpStatus.noContent);
    },
    onError: (e) {
      return Response(statusCode: HttpStatus.badRequest);
    },
  );
  return Response(statusCode: HttpStatus.badRequest);
}
