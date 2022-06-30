class CategoryEntity {
  int? id;
  String? name;
  String? icon;
  int? type;

  CategoryEntity({
    this.id,
    this.name,
    this.icon,
    this.type,
  });

  CategoryEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    icon = map['icon'];
    type = map['type'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['icon'] = icon;
    return map;
  }
}
