import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'list_repositoty.g.dart';

@visibleForTesting

/// data source in memory cache
Map<String, TaskList> listDb = {};

@JsonSerializable()

/// TaskList class
class TaskList extends Equatable {
  /// constructor
  const TaskList({
    required this.id,
    required this.name,
  });

  /// deserialization
  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  /// list's id
  final String id;

  /// list's name
  final String name;

  @override
  List<Object> get props => [id, name];

  ///
  TaskList copyWith({
    String? id,
    String? name,
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  /// serialization
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  @override
  bool get stringify => true;
}

/// list repository calss for taskList
class ListRepositoty {
  /// check the internal data sorce for list wiht given id
  Future<TaskList?> listById(String id) async {
    return listDb[id];
  }

  /// get all the list from data source
  Map<String, dynamic> getAllLists() {
    final formattedLists = <String, dynamic>{};

    if (listDb.isNotEmpty) {
      listDb.forEach((key, value) {
        formattedLists[key] = value.toJson();
      });
    }

    return formattedLists;
  }

  /// Create a new list with a given [name]
  String createList({required String name}) {
    /// dynamically generates the id
    final id = name.hashValue;

    /// create our new TaskList object and pass our two parameters
    final list = TaskList(id: id, name: name);

    /// add a new Tasklist object to our data source
    listDb[id] = list;

    return id;
  }

  /// Deletes the Tasklist object with the given [id]
  void deleteList(String id) {
    listDb.remove(id);
  }

  /// Update operation
  Future<void> updateList({required String id, required String name}) async {
    final currentlist = listDb[id];

    if (currentlist == null) {
      return Future.error(Exception('List not found'));
    }

    listDb[id] = TaskList(id: id, name: name);
  }
}
