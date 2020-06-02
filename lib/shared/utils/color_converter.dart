import 'dart:ui';

Color convertFromString(String color) {
  return Color(int.parse(color.split('(0x')[1].split(')')[0], radix: 16));
}
