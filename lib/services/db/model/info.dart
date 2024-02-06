import 'package:isar/isar.dart';

part 'info.g.dart';

@collection
class DataInfo {
  Id id = 1;

  late final String fetchedAt;

  late final double gpa;
}
