class TransactionEntity {
  int? id;
  String? type;
  int? date;
  int? nominal;
  String? category;
  String? name;
  String? color;
  int? savingId;

  TransactionEntity({
    this.id,
    this.type,
    this.date,
    this.nominal,
    this.category,
    this.name,
    this.color,
    this.savingId,
  });

  TransactionEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    type = map['type'];
    date = map['date'];
    nominal = map['nominal'];
    category = map['category'];
    name = map['name'];
    color = map['color'];
    savingId = map['savingId'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['type'] = type;
    map['date'] = date;
    map['nominal'] = nominal;
    map['category'] = category;
    map['name'] = name;
    map['color'] = color;
    map['savingId'] = savingId;
    return map;
  }
}
