
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class DatavalidatorAddOffer{

//-----------------------------------------------
  final _arnameprofile = StreamController<String>.broadcast();
  Stream<String> get  arnameprofile => _arnameprofile.stream.transform(validationarNameprofile);
  final  validationarNameprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Name');
    }else{

      sink.add(name);
    }
  }  );
  changeName (v){
    _arnameprofile.sink.add(v);

  }
  //====================================================================
//-----------------------------------------------
  final _ennameprofile = StreamController<String>.broadcast();
  Stream<String> get  ennameprofile => _ennameprofile.stream.transform(validationenNameprofile);
  final  validationenNameprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenName (v){
    _ennameprofile.sink.add(v);

  }
//====================================================================
//-----------------------------------------------
  final _ardesprofile = StreamController<String>.broadcast();
  Stream<String> get  ardesprofile => _ardesprofile.stream.transform(validationardesprofile);
  final  validationardesprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('وصف غير صحيح');
    }else{

      sink.add(name);
    }
  }  );
  changeardes (v){
    _ardesprofile.sink.add(v);

  }
//====================================================================
  final _endesprofile = StreamController<String>.broadcast();
  Stream<String> get  endesprofile => _endesprofile.stream.transform(validationendesprofile);
  final  validationendesprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Details');
    }else{

      sink.add(name);
    }
  }  );
  changeendes (v){
    _endesprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _passwordprofileprofile = StreamController<String>.broadcast();
  Stream<String> get  passwordprofile => _passwordprofileprofile.stream.transform(validationpasswordprofile);
  final  validationpasswordprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<5) {

      // get it from
      sink.addError('Not Valid password');
    }else{

      sink.add(name);
    }
  }  );
  changepasswordprofile(v){
    _passwordprofileprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _whatsappprofile = StreamController<String>.broadcast();
  Stream<String> get  whatsappprofile => _whatsappprofile.stream.transform(validationwhatsappprofile);
  final  validationwhatsappprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<7) {

      // get it from
      sink.addError('Not Valid whatsapp');
    }else{

      sink.add(name);
    }
  }  );
  changewhatsapp(v){
    _whatsappprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _arDistrictprofile = StreamController<String>.broadcast();
  Stream<String> get  arDistrictprofile => _arDistrictprofile.stream.transform(validationararDistrictprofile);
  final  validationararDistrictprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid District');
    }else{

      sink.add(name);
    }
  }  );
  changearDistrict(v){
    _arDistrictprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _enDistrictprofile = StreamController<String>.broadcast();
  Stream<String> get  enDistrictprofile => _enDistrictprofile.stream.transform(validationenenDistrictprofile);
  final  validationenenDistrictprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid District');
    }else{

      sink.add(name);
    }
  }  );
  changeenDistrict(v){
    _enDistrictprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _arStreetNameprofile = StreamController<String>.broadcast();
  Stream<String> get  arStreetNameprofile => _arStreetNameprofile.stream.transform(validationenarStreetNameprofile);
  final  validationenarStreetNameprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('اسم الشارع غير صحيح');
    }else{

      sink.add(name);
    }
  }  );
  changeenarStreetName(v){
    _arStreetNameprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _enStreetNameprofile = StreamController<String>.broadcast();
  Stream<String> get  enStreetNameprofile => _arStreetNameprofile.stream.transform(validationenenStreetNameprofile);
  final  validationenenStreetNameprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid Street Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenenStreetName(v){
    _enStreetNameprofile.sink.add(v);

  }
//====================================================================
//====================================================================
  final _bilednumberprofile = StreamController<String>.broadcast();
  Stream<String> get   bilednumberprofile => _bilednumberprofile.stream.transform(validationenbilednumberprofile);
  final  validationenbilednumberprofile =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid Street Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenenbilednumber(v){
    _bilednumberprofile.sink.add(v);

  }
//====================================================================
Stream<bool> get _part1 => Rx.combineLatest5(arnameprofile, ennameprofile,ardesprofile, endesprofile,passwordprofile , (a, b, c,d ,e) => true).asBroadcastStream();
  Stream<bool> get _part2 => Rx.combineLatest6(whatsappprofile, arDistrictprofile,enDistrictprofile, arStreetNameprofile,enStreetNameprofile ,bilednumberprofile,(a, b, c,d ,e,f) => true).asBroadcastStream();
  Stream<bool> get profilevileddatastraim => Rx.combineLatest2(_part1, _part2, (a, b,) => true);



  despoos(){

    if(!_arStreetNameprofile.isClosed){
      _arStreetNameprofile.close();
    }
    if(!_whatsappprofile.isClosed){
      _whatsappprofile.close();
    }
    if(!_endesprofile.isClosed){
      _endesprofile.close();
    }
    if(!_passwordprofileprofile.isClosed){
      _passwordprofileprofile.close();
    }
    if(!_ardesprofile.isClosed){
      _ardesprofile.close();
    }
    if(!_ennameprofile.isClosed){
      _ennameprofile.close();
    }
    if(!_arDistrictprofile.isClosed){
      _arDistrictprofile.close();
    }
//--------------
    if(!_enDistrictprofile.isClosed){
      _enDistrictprofile.close();
    }
    if(!_bilednumberprofile.isClosed){
      _bilednumberprofile.close();
    }
    if(!_enStreetNameprofile.isClosed){
      _enStreetNameprofile.close();
    }
    if(!_arnameprofile.isClosed){
      _arnameprofile.close();
    }

  }
  }