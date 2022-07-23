import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';

class LazyLoadApiModel extends LazyLoadApiEntity {
  LazyLoadApiModel(
      {required String name,
      required String id})
      : super(
            name,
            id);

  factory LazyLoadApiModel.fromJson(Map<dynamic, dynamic> json) {
    return LazyLoadApiModel(
      name: json['employee_name'].toString(),
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
      };
}
