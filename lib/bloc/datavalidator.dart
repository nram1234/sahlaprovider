
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class DataValidator   {


  final _namemy = BehaviorSubject<String>();
  final _phonemy = BehaviorSubject<String>();
  final _addressmy = BehaviorSubject<String>();
  final _passwordmy = BehaviorSubject<String>();

  //get
  Stream<String> get  namemy => _namemy.stream.transform(validationNamemy);
  Stream<String> get  passwordmy => _passwordmy.stream.transform(validationpasswordmy);
  Stream<String> get  phonemy => _phonemy.stream.transform(validationPhonemy);
  Stream<String> get  addressmy => _addressmy.stream.transform(validationaddressmy);



  Stream<bool> get validationUserDatamy => Rx.combineLatest2(passwordmy, phonemy,   (a, b,  ) => true);
//set
  changeName (v){
    _namemy.sink.add(v);
  }
  changephone(v){
    _phonemy.sink.add(v);
  }
  changepassword(v){
    _passwordmy.sink.add(v);
  }
  changeaddress(v){
    _addressmy.sink.add(v);
  }

//Transform
  final  validationNamemy =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<3) {

      // get it from
      sink.addError('Not Valid Name');
    }else{

      sink.add(name);
    }
  }  );
  final  validationpasswordmy =StreamTransformer<String,String>.fromHandlers(handleData: (password,sink){

    if(password.length<6) {

      // get it from
      sink.addError('Not Valid password');
    }else{

      sink.add(password);
    }
  }  );
  final validationPhonemy=StreamTransformer<String,String>.fromHandlers(handleData: (phone,sink){

    if(phone.length<7) {
      // get it from
      sink.addError( 'Not Valid Phone Number');
    }else{
      sink.add(phone);
    }
  }  );
  final validationaddressmy=StreamTransformer<String,String>.fromHandlers(handleData: (address,sink){

    if(address.length<5) {
      // get it from
      sink.addError( 'Not Valid address');
    }else{
      sink.add(address);
    }
  }  );



  despoos(){
    if(!_namemy.isClosed){
      _namemy.close();
    }
    if(!_passwordmy.isClosed){
      _passwordmy.close();
    }
    if(!_phonemy.isClosed){
      _phonemy.close();
    }
    if(!_addressmy.isClosed){
      _addressmy.close();
    }


  }
}
