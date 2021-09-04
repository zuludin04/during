class SavingEntity {
  int? id;
  String? name;
  int? balance;
  String? color;
  int? date;

  SavingEntity({
    this.id,
    this.name,
    this.balance,
    this.color,
    this.date,
  });

  SavingEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
    color = map['color'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = id;
    map['name'] = name;
    map['balance'] = balance;
    map['color'] = color;
    map['date'] = date;
    return map;
  }
}
