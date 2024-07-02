
import 'package:hive_flutter/hive_flutter.dart';
part 'search_history.g.dart';

@HiveType(typeId: 0)
class SearchHistory{
  @HiveField(0)
  late String startRoute;
  @HiveField(1)
  late String endRoute;
  @HiveField(2)
  late DateTime timeStamp;
  SearchHistory( this.startRoute, this.endRoute, this.timeStamp);
}