import 'package:flutter/material.dart';
import 'package:lina_pharmacy/screens/color_plate.dart';

Color colorChanger(String selfName) {
  if (selfName[0] == 'A') return kColorA;
  if (selfName[0] == 'B') return kColorB;
  if (selfName[0] == 'C') return kColorC;
  if (selfName[0] == 'D') return kColorD;
  if (selfName[0] == 'E') return kColorE;
  if (selfName[0] == 'F') return kColorF;
  if (selfName[0] == 'G') return kColorG;
  if (selfName[0] == 'H') return kColorH;
  if (selfName[0] == 'I') return kColorI;
  if (selfName[0] == 'J') return kColorJ;
  if (selfName[0] == 'K') return kColorK;
  if (selfName[0] == 'L') return kColorL;
  if (selfName[0] == 'M') return kColorM;
  if (selfName[0] == 'N') return kColorN;
  if (selfName[0] == 'O') return kColorO;
  if (selfName[0] == 'P') return kColorP;
  if (selfName[0] == 'Q') return kColorQ;
  if (selfName[0] == 'X') return kColorX;
  if (selfName[0] == 'Z') return kColorZ;

  return Colors.white;
}
