import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smam_tddclean/core/constants/messages.dart';
import 'package:smam_tddclean/core/utility/json_key.dart';
import 'package:smam_tddclean/core/utility/utility.dart';

String deviceId = '';
bool isLoginToken = false;
String? authorizationHeader;

Future<dynamic> doApiCall(
    {String? url, Map<String, dynamic>? params, bool isGetApi = true}) async {
  try {
    if (await checkInternet()) {
      // final FormData formData = FormData.fromMap(params!);

      // Map<String, String> headers;
      // const String username = 'sangita@abc.com';
      // const String password = 'admin@1234';

      // authorizationHeader =
      //     'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      // headers = <String, String>{'Authorization': authorizationHeader!};
      Response<dynamic> response;
      if (isGetApi) {
        response = await Dio().get(
          url!,
        );
      } else {
        response = await Dio()
            .post(url!, data: params,/*  options: Options(headers: headers) */);
      }
      // ignore: unnecessary_null_comparison
      if (response != null) {
        final int? statusCode = response.statusCode;
        switch (statusCode) {
          case 200:
            return response.data;
          case 500:
            return <dynamic, dynamic>{
              keySuccess: false,
              keyError: <dynamic, dynamic>{keyMessage: msgInternalServerError}
            };
          case 302:
            return <dynamic, dynamic>{
              keySuccess: false,
              keyError: <dynamic, dynamic>{keyMessage: msgInternalServerError}
            };

          default:
            return <dynamic, dynamic>{
              keySuccess: false,
              keyError: <dynamic, dynamic>{keyMessage: msgSomethingWentWrong}
            };
        }
      } else {
        return <dynamic, dynamic>{
          keySuccess: false,
          keyError: <dynamic, dynamic>{keyMessage: msgNoInternetConnection}
        };
      }
    } else {
      return <dynamic, dynamic>{
        keySuccess: false,
        keyError: <dynamic, dynamic>{keyMessage: msgNoInternetConnection}
      };
    }
  } catch (error) {
    String errorDescription = '';

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = errorCancel;
          break;
        case DioErrorType.connectTimeout:
          errorDescription = errorTimeOut;
          break;
        case DioErrorType.other:
          errorDescription = msgNoInternetConnection2;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = errorReceiveTimeOut;
          break;
        case DioErrorType.response:
          errorDescription =
              'Received invalid status code: ${error.response!.statusCode}';
          break;
        case DioErrorType.sendTimeout:
          errorDescription = errorSendTimeOUT;
          break;
      }
      return <dynamic, dynamic>{
        keySuccess: false,
        keyError: <dynamic, dynamic>{keyMessage: errorDescription}
      };
    } else {
      return <dynamic, dynamic>{
        keySuccess: false,
        keyError: <dynamic, dynamic>{keyMessage: msgSomethingWentWrong}
      };
    }
  }
}

bool parseResponse({Map<dynamic, dynamic>? responseMap}) {
  bool isParseResponse = false;
  if (responseMap != null) {
    final bool? isSuccess = responseMap[keySuccess] as bool?;
    if (isSuccess != null && isSuccess) {
      isParseResponse = true;
    } else {
      isParseResponse = false;
    }
  } else {
    isParseResponse = false;
  }

  return isParseResponse;
}

String getFailedErrorMessage({Map<dynamic, dynamic>? reponseMap}) {
  if (reponseMap != <dynamic, dynamic>{}) {
    final Map<dynamic, dynamic> mapError =
        reponseMap![keyError] as Map<dynamic, dynamic>;
    final String errorMessage = mapError[keyMessage].toString();
    return errorMessage;
  } else {
    return msgSomethingWentWrong;
  }
}
