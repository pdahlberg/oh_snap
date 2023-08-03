import 'package:json_annotation/json_annotation.dart';

part 'underdog_project.g.dart';

@JsonSerializable()
class UnderdogProject {
  int id;
  String name;

  UnderdogProject({
    required this.id,
    required this.name,
  });

  factory UnderdogProject.fromJson(Map<String, dynamic> json) => _$UnderdogProjectFromJson(json);
  Map<String, dynamic> toJson() => _$UnderdogProjectToJson(this);

  @override
  String toString() {
    return 'UnderdogProject{$id, $name}';
  }
}
