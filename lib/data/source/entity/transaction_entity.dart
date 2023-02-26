class TransactionEntity {
  int? id;
  String? type;
  int? date;
  int? nominal;
  int? categoryId;
  String? name;
  int? savingId;
  String? savingName;

  String? categoryName;
  int? categoryType;
  String? categoryIcon;
  String? categoryColor;

  TransactionEntity({
    this.id,
    this.type,
    this.date,
    this.nominal,
    this.categoryId,
    this.name,
    this.savingId,
    this.savingName,
  });

  TransactionEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    date = map['date'];
    nominal = map['nominal'];
    categoryId = map['categoryId'];
    name = map['name'];
    savingId = map['savingId'];
    savingName = map['savingName'];
  }

  TransactionEntity.fromJoinDb(Map<String, dynamic> map) {
    categoryName = map['categoryName'];
    categoryType = map['categoryType'];
    categoryIcon = map['categoryIcon'];
    categoryColor = map['categoryColor'];
    id = map['id'];
    type = map['type'];
    date = map['date'];
    nominal = map['nominal'];
    categoryId = map['categoryId'];
    name = map['name'];
    savingId = map['savingId'];
    savingName = map['savingName'];
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
    map['savingName'] = savingName;
    return map;
  }
}
