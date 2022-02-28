import 'package:dio/dio.dart';
import 'package:json_serializable/type_helper.dart';

class HttpService{
  Dio? _dio;

  final baseUrl= "http://limitlessapi.pythonanywhere.com/api/docs/";

  HttpService(){
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,

    ));
    initializeInterceptors();
  }

  Future<Response>getRequest(String endPoint) async {
    Response response;

    try {
      response =  await _dio!.get(endPoint);
    }on DioError catch (e){
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }




  initializeInterceptors(){
    _dio!.interceptors.add(InterceptorsWrapper(
    onError: (error, handler){
      print("${error.message}");
      return handler.next(error);
    },
    onRequest: (request,handler){
     print("${request.method}${request.baseUrl})${request.path}");
     return handler.next(request);
    },
      onResponse: (response,handler){
      print("${response.data}");
      return handler.next(response);
      }

    ));


  }
  }