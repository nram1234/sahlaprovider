
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class DatavalidatorAddPranch{

//-----------------------------------------------
  final _arnameprPranch = StreamController<String>.broadcast();
  Stream<String> get  arnameprPranch => _arnameprPranch.stream.transform(validationarNamePranch);
  final  validationarNamePranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Name');
    }else{

      sink.add(name);
    }
  }  );
  changeName (v){
    _arnameprPranch.sink.add(v);

  }
  //====================================================================
//-----------------------------------------------
  final _ennamePranch = StreamController<String>.broadcast();
  Stream<String> get  ennamePranch => _ennamePranch.stream.transform(validationenNamePranch);
  final  validationenNamePranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenName (v){
    _ennamePranch.sink.add(v);

  }
//====================================================================
//-----------------------------------------------
  final _mobilePranch = StreamController<String>.broadcast();
  Stream<String> get  mobilePranch => _mobilePranch.stream.transform(validationarmobilePranch);
  final  validationarmobilePranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<7) {

      // get it from
      sink.addError('رقم غير صحيح');
    }else{

      sink.add(name);
    }
  }  );
  changearmobile (v){
    _mobilePranch.sink.add(v);

  }
//====================================================================
  final _endesPranch = StreamController<String>.broadcast();
  Stream<String> get  endesPranch => _endesPranch.stream.transform(validationendesPranch);
  final  validationendesPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Details');
    }else{

      sink.add(name);
    }
  }  );
  changeendes (v){
    _endesPranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _passwordPranch = StreamController<String>.broadcast();
  Stream<String> get  passwordPranch => _passwordPranch.stream.transform(validationpasswordPranch);
  final  validationpasswordPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<5) {

      // get it from
      sink.addError('Not Valid password');
    }else{

      sink.add(name);
    }
  }  );
  changepasswordprofile(v){
    _passwordPranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _whatsappPranch = StreamController<String>.broadcast();
  Stream<String> get  whatsappPranch => _whatsappPranch.stream.transform(validationwhatsappPranch);
  final  validationwhatsappPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<7) {

      // get it from
      sink.addError('Not Valid whatsapp');
    }else{

      sink.add(name);
    }
  }  );
  changewhatsapp(v){
    _whatsappPranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _arDistrictPranch = StreamController<String>.broadcast();
  Stream<String> get  arDistrictpPranch => _arDistrictPranch.stream.transform(validationararDistrictPranch);
  final  validationararDistrictPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid District');
    }else{

      sink.add(name);
    }
  }  );
  changearDistrict(v){
    _arDistrictPranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _enDistrictPranch = StreamController<String>.broadcast();
  Stream<String> get  enDistrictPranch => _enDistrictPranch.stream.transform(validationenenDistrictPranch);
  final  validationenenDistrictPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid District');
    }else{

      sink.add(name);
    }
  }  );
  changeenDistrict(v){
    _enDistrictPranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _arStreetNamePranch = StreamController<String>.broadcast();
  Stream<String> get  arStreetNamePranch => _arStreetNamePranch.stream.transform(validationenararStreetNamePranch);
  final  validationenararStreetNamePranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('اسم الشارع غير صحيح');
    }else{

      sink.add(name);
    }
  }  );
  changeenarStreetName(v){
    _arStreetNamePranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _enStreetNamePranch = StreamController<String>.broadcast();
  Stream<String> get  enStreetNamePranch => _enStreetNamePranch.stream.transform(validationenenStreetNamePranch);
  final  validationenenStreetNamePranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<2) {

      // get it from
      sink.addError('Not Valid Street Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenenStreetName(v){
    _enStreetNamePranch.sink.add(v);

  }
//====================================================================
//====================================================================
  final _bilednumberPranch = StreamController<String>.broadcast();
  Stream<String> get   bilednumberPranch => _bilednumberPranch.stream.transform(validationenbilednumberPranch);
  final  validationenbilednumberPranch =StreamTransformer<String,String>.fromHandlers(handleData: (name,sink){

    if(name.length<1) {

      // get it from
      sink.addError('Not Valid Street Name');
    }else{

      sink.add(name);
    }
  }  );
  changeenenbilednumber(v){
    _bilednumberPranch.sink.add(v);

  }
//====================================================================
  Stream<bool> get _part1 => Rx.combineLatest5(arnameprPranch, ennamePranch,mobilePranch, endesPranch,passwordPranch , (a, b, c,d ,e) => true).asBroadcastStream();
  Stream<bool> get _part2 => Rx.combineLatest6(whatsappPranch, arDistrictpPranch,enDistrictPranch, arStreetNamePranch,enStreetNamePranch ,bilednumberPranch,(a, b, c,d ,e,f) => true).asBroadcastStream();
  Stream<bool> get profilevileddatastraim => Rx.combineLatest2(_part1, _part2, (a, b,) => true);



  despoos(){

    if(!_arStreetNamePranch.isClosed){
      _arStreetNamePranch.close();
    }
    if(!_whatsappPranch.isClosed){
      _whatsappPranch.close();
    }
    if(!_endesPranch.isClosed){
      _endesPranch.close();
    }
    if(!_passwordPranch.isClosed){
      _passwordPranch.close();
    }
    if(!_mobilePranch.isClosed){
      _mobilePranch.close();
    }
    if(!_ennamePranch.isClosed){
      _ennamePranch.close();
    }
    if(!_arDistrictPranch.isClosed){
      _arDistrictPranch.close();
    }
//--------------
    if(!_enDistrictPranch.isClosed){
      _enDistrictPranch.close();
    }
    if(!_bilednumberPranch.isClosed){
      _bilednumberPranch.close();
    }
    if(!_enStreetNamePranch.isClosed){
      _enStreetNamePranch.close();
    }
    if(!_arnameprPranch.isClosed){
      _arnameprPranch.close();
    }

  }
}