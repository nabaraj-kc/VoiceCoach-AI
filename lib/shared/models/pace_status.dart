import 'package:flutter/material.dart';

enum PaceStatus { ideal, caution, alert }

extension PaceStatusColor on PaceStatus {
  Color get color {
    switch (this) {
      case PaceStatus.ideal:
        return const Color(0xFF4ADE80);
      case PaceStatus.caution:
        return const Color(0xFFFACC15);
      case PaceStatus.alert:
        return const Color(0xFFF87171);
    }
  }
}
