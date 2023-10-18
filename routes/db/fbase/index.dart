import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getLists(context),
    HttpMethod.post => _createList(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _getLists(RequestContext context) async {
  final lists = <Map<String, dynamic>>[];

  await Firestore.instance.collection('tasklists').get().then((event) {
    for (final doc in event) {
      lists.add(doc.map);
    }
  });

  return Response.json(body: lists);
}

Future<Response> _createList(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  final description = body['description'] as String?;
  final status = body['status'] as String?;
  final listId = body['listId'] as String?;

  final list = <String, dynamic>{
    'name': name,
    'description': description,
    'status': status,
    'listId': listId,
  };

  final id =
      await Firestore.instance.collection('tasklists').add(list).then((doc) {
    return doc.id;
  });

  return Response.json(body: {
    'id': id,
    'name': name,
    'description': description,
    'status': status,
    'listId': id,
  });
}
