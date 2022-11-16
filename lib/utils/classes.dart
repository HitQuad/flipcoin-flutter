import 'package:easy_localization/easy_localization.dart';

class Flips {
  String? name;
  int? count;

  Flips(
    this.name,
    this.count,
  );
}

List<Flips> fList = [
  Flips("5 "+"Flips".tr(), 5),
  Flips("10 "+"Flips".tr(), 10),
  Flips("15 "+"Flips".tr(), 15),
];

class RadioClass {
  String? name;
  int? index;

  RadioClass(
    this.name,
    this.index,
  );
}

List<RadioClass> rList = [
  RadioClass("heads", 1),
  RadioClass("Tails", 2),
];

class Coins {
  String? name;
  String? key;

  Coins(
    this.name,
    this.key,
  );
}

List<Coins> coinsList = [
  Coins('Default Coin', 'def'),
  Coins('India Coin', 'ind'),
  Coins('American Coin', 'usa'),
  Coins('Canada Coin', 'can'),
  Coins('Africa Coin', 'sa'),
  Coins('Cent Coin', 'cen'),
  Coins('Dime Coin', 'dim'),
  Coins('Dollar Coin', 'dol'),
  Coins('Nickle Coin', 'nic'),
  Coins('Quarter Coin', 'qua')
];
