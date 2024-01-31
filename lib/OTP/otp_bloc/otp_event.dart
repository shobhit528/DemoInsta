import 'package:flutter/material.dart';

@immutable
abstract class OTPEvent {}

class InitialEvent extends OTPEvent{}
class VerifyClickEvent extends OTPEvent{}