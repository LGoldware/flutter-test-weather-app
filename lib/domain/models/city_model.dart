import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

class CityModel with Mappable, EquatableMixin {
  int? id;
  String? name;
  String? country;

  String get fullName => '$name, $country';

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("name", name, (v) => name = v);
    map("sys.country", country, (v) => country = v);
  }

  @override
  List<Object?> get props => [id, name, country];
}
