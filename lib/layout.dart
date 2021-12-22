import 'package:flutter/foundation.dart';

double letterSpacingOrNone(double letterSpacing) =>
    kIsWeb ? 0.0 : letterSpacing;
