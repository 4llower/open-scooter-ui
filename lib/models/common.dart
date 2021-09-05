class Location {
  final int lag;
  final int lng;

  Location(this.lag, this.lng);
}

class CreditCard {
  final String type;
  final String id;

  CreditCard(this.type, this.id);
}

class ScooterCost {
  final int unlock;
  final int perMinute;
  final String unit;

  ScooterCost(this.unlock, this.perMinute, this.unit);
}

class Scooter {
  final Location location;
  final int chargeLevel;
  final ScooterCost cost;
  final int? rentStartTime;
  final int? bookStartTime;

  Scooter(this.location, this.chargeLevel, this.cost, this.rentStartTime,
      this.bookStartTime);
}
