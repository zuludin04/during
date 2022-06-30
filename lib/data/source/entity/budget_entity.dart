class BudgetEntity {
  int? id;
  String? name;
  String? color;
  String? icon;
  int? total;
  int? percent;
  int? used;
  int? finishDate;
  int? savingId;

  BudgetEntity({
    this.id,
    this.name,
    this.color,
    this.icon,
    this.total,
    this.percent,
    this.used,
    this.finishDate,
    this.savingId,
  });

  BudgetEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    color = map['color'];
    icon = map['icon'];
    total = map['total'];
    percent = map['percent'];
    used = map['used'];
    finishDate = map['finishDate'];
    savingId = map['savingId'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['color'] = color;
    map['icon'] = icon;
    map['total'] = total;
    map['percent'] = percent;
    map['used'] = used;
    map['finishDate'] = finishDate;
    map['savingId'] = savingId;
    return map;
  }
}
