import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final connection = PostgreSQLConnection(
      'localhost',
      5432,
      'mytasklists',
      username: 'postgres',
      password: 'progress2580',
    );

    await connection.open();

    final response = await handler
        .use(provider<PostgreSQLConnection>((_) => connection))
        .call(context);

    await connection.close();

    return response;
  };
}
