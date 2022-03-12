class SavingEntity {
  int? id;
  String? name;
  int? balance;
  String? color;
  int? date;
  String? category;

  SavingEntity({
    this.id,
    this.name,
    this.balance,
    this.color,
    this.date,
    this.category,
  });

  SavingEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
    color = map['color'];
    date = map['date'];
    category = map['category'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = id;
    map['name'] = name;
    map['balance'] = balance;
    map['color'] = color;
    map['date'] = date;
    map['category'] = category;
    return map;
  }
}
