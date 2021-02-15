
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class datavalidatorAddOffer{


  final _nameoffer = BehaviorSubject<String>();
  final _ennameoffer = BehaviorSubject<String>();
 // final _priceoffer = BehaviorSubject<String>();
 // final _price2offer = BehaviorSubject<String>();

  final _ardesoffer = BehaviorSubject<String>();
  final _endesoffer = BehaviorSubject<String>();
  //get
  Stream<String> get  nameoffer => _nameoffer.stream.transform(validationName);
  Stream<String> get  ennameoffer => _ennameoffer.stream.transform(validationEnname);
 // Stream<String> get  priceoffer => _priceoffer.stream.transform(validationPrice);
 // Stream<String> get  price2offer => _price2offer.stream.transform(validationPrice2);

  Stream<String> get  ardesoffer => _ardesoffer.stream.transform(validationPrice);
  Stream<String> get  endesoffer => _endesoffer.stream.transform(validationPrice2);


  Stream<bool> get validationUserDataoffer => Rx.combineLatest2(nameoffer, ennameoffer,(a, b ) => true);

  Stream<bool> get validationaddnewprodectoffer => Rx.combineLatest2(nameoffer, ennameoffer,   (a, b  ) => true);
//set
  changeName (v){
  _nameoffer.sink.add(v);

  }
  changeenname(v){
  _ennameoffer.sink.add(v);

  }
  // changeprice2(v){
  // _price2offer.sink.add(v);
  //
  // }
  // changeprice(v){
  // _priceoffer.sink.add(v);
  //
  // }
//--
  changeardes(v){
    _ardesoffer.sink.add(v);

  }
  changeendes(v){
    _endesoffer.sink.add(v);

  }
//Transform
  final  validationName =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

  if(name.length<1) {

  // get it from
  sink.addError('Not Valid Name');
  }else{

  sink.add(name);
  }
  }  );
  final  validationEnname =StreamTransformer<String,String>.fromHandlers(handleData: (password,sink){

  if(password.length<1) {

  // get it from
  sink.addError('Not Valid Name');
  }else{

  sink.add(password);
  }
  }  );
  final validationPrice=StreamTransformer<String,String>.fromHandlers(handleData: (phone,sink){

  if(phone.length<1) {
  // get it from
  sink.addError( 'Not Valid price');
  }else{
  sink.add(phone);
  }
  }  );
  final validationPrice2=StreamTransformer<String,String>.fromHandlers(handleData: (address,sink){

  if(address.length<1) {
  // get it from
  sink.addError( 'Not Valid price');
  }else{
  sink.add(address);
  }
  }  );

  final validationardes=StreamTransformer<String,String>.fromHandlers(handleData: (arde,sink){


      sink.add(arde);

  }  );
  final validationendes=StreamTransformer<String,String>.fromHandlers(handleData: (endes,sink){


    sink.add(endes);

  }  );

  despoos(){
  if(!_nameoffer.isClosed){
  _nameoffer.close();
  }
  // if(!_price2offer.isClosed){
  // _price2offer.close();
  // }
  if(!_ennameoffer.isClosed){
  _ennameoffer.close();
  }
  // if(!_priceoffer.isClosed){
  // _priceoffer.close();
  // }


  }
  }
