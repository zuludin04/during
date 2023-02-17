class TransactionEntity {
  int? id;
  String? type;
  int? date;
  int? nominal;
  int? categoryId;
  String? name;
  int? savingId;

  String? categoryName;
  int? categoryType;
  String? categoryIcon;
  String? categoryColor;
  String? savingColor;

  TransactionEntity({
    this.id,
    this.type,
    this.date,
    this.nominal,
    this.categoryId,
    this.name,
    this.savingId,
  });

  TransactionEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    date = map['date'];
    nominal = map['nominal'];
    categoryId = map['categoryId'];
    name = map['name'];
    savingId = map['savingId'];
  }

  TransactionEntity.fromJoinDb(Map<String, dynamic> map) {
    categoryName = map['categoryName'];
    categoryType = map['categoryType'];
    categoryIcon = map['categoryIcon'];
    categoryColor = map['categoryColor'];
    savingColor = map['savingColor'];
    id = map['id'];
    type = map['type'];
    date = map['date'];
    nominal = map['nominal'];
    categoryId = map['categoryId'];
    name = map['name'];
    savingId = map['savingId'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['type'] = type;
    map['date'] = date;
    map['nominal'] = nominal;
    map['categoryId'] = categoryId;
    map['name'] = name;
    map['savingId'] = savingId;
    return map;
  }
}
