import 'package:flutter/material.dart';

InputDecoration decoration = const InputDecoration(
  disabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide.none),
  filled: true,
  fillColor: Color.fromRGBO(0, 0, 0, 0.06),
  // suffixIcon: Icon(Icons.calendar_month_rounded),
);
