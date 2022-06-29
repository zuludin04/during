class SavingEntity {
  int? id;
  String? name;
  int? balance;
  String? color;
  int? date;
  int? categoryId;

  String? categoryName;
  int? categoryType;
  String? categoryIcon;

  SavingEntity({
    this.id,
    this.name,
    this.balance,
    this.color,
    this.date,
    this.categoryId,
  });

  SavingEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
    color = map['color'];
    date = map['date'];
    categoryId = map['categoryId'];
  }

  SavingEntity.fromJoinDb(Map<String, dynamic> map) {
    categoryName = map['categoryName'];
    categoryType = map['categoryType'];
    categoryIcon = map['categoryIcon'];
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
    color = map['color'];
    date = map['date'];
    categoryId = map['categoryId'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['balance'] = balance;
    map['color'] = color;
    map['date'] = date;
    map['categoryId'] = categoryId;
    return map;
  }
}
