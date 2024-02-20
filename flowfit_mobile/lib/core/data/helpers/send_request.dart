import 'dart:convert';

import 'package:flowfit_mobile/core/data/helpers/http_method.dart';
import 'package:http/http.dart';


dynamic _parseBody(dynamic body){
  try{
    return jsonEncode(body);
  }
  catch(_){
    return body;
  }
}

Future<Response> sendRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String,String> headers,
  required dynamic body,
  required Duration timeOut  
}){

   var finalHeaders = {...headers};

   if(method != HttpMethod.get){
    final contentType = headers['Content-Type'];
    if(contentType == null || contentType.contains('application/json')){
      finalHeaders['Content-Type'] = 'application/json; charset=utf-8';
       body = _parseBody(body);
    }
   }

   final client = Client();

  switch(method){
    case HttpMethod.get:
    return client.get(url, headers: finalHeaders,).timeout(timeOut);
    case HttpMethod.post:
    return client.post(url, headers: finalHeaders, body: body,).timeout(timeOut);
    case HttpMethod.put:
    return client.post(url, headers: finalHeaders, body: body,).timeout(timeOut);
    }
}