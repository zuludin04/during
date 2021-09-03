class SavingEntity {
  int? id;
  String? name;
  int? balance;
  String? color;

  SavingEntity({
    this.id,
    this.name,
    this.balance,
    this.color,
  });

  SavingEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    balance = map['balance'];
    color = map['color'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = id;
    map['name'] = name;
    map['balance'] = balance;
    map['color'] = color;
    return map;
  }
}
