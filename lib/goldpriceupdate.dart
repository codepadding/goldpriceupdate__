library goldpriceupdate;

export 'src/gold_price_update.dart';
export 'src/gold_price_provider.dart' show GoldPriceProvider;
export "src/gold_price_provider.dart" hide GoldPrice;

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
