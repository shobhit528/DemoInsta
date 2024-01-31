
abstract class OTPState{}

abstract class OTPActionState extends OTPState{}

class OTPInitial extends OTPState{}
class OTPVerifySuccess extends OTPState{}
class OTPVerifyFail extends OTPState{}
class OTPResend extends OTPState{}
