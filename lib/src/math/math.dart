import 'dart:math';

/// Suplement dart math with a rounding function
double roundDouble(double value, int places){ 
   double mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}
