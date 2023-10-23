import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repository/items/item_repository.dart';
import 'package:tasklist_backend/repository/list/list_repositoty.dart';

Handler middleware(Handler handler) {
  // return handler.use(requestLogger()).use(
  //       provider<String>(
  //         (context) => 'Dart Frog tutorial',
  //       ),
  //     );
  return handler
      .use(requestLogger())
      .use(provider<TaskListRepositoty>((context) => TaskListRepositoty()))
      .use(provider<TaskItemRepository>((context) => TaskItemRepository()));
}
