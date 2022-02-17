part of vonage_dart;

/// Vonage Verify Users With Numbers
/// Instiantiate Vonage with your [VONAGE_API_KEY and VONAGE_API_SECRET] from https://developer.nexmo.com/verify to get
/// clean interface with vonage API
///
///
/// ```dart
/// void main() async {
///   final Vonage vonage = Vonage(api_key: "VONAGE_API_KEY", api_secret: "VONAGE_API_SECRET");
///   final vonageVerifyResponse res = await vonage.verify(number: "XXxxxxxxxx",brand:"BRAND NAME",code_length=4);
///   print(res.request_id); // returns ->  "request_id": "xxxxxxxx"
///   final vonageVerifyCheckResponse resp = await vonage.check(request_id:"xxx", code:"xxxx");
///   print(resp.event_id); // returns -> event_id
/// }
/// ```
///


class Vonage{
  final String api_key;
  final String api_secret;
  final _baseurl = "https://api.nexmo.com";
  final Map<String, String> _headers ={'Content-Type': 'application/x-www-form-urlencoded','Content-Type': 'application/json'};


  Vonage({
    required this.api_key,
    required this.api_secret}):
      assert(api_key.isNotEmpty, "api_key cannot be empty"),
      assert(api_secret.isNotEmpty, "api_secret cannot be empty");

  /// Send verify request to the nexmo API
  /// This will send the 4 or 6 digit SMS.
  /// [String] number == with country code without + and without 00
  /// [String] brand  == Name of App or Your Business Name
  /// [int] code_length == 4 digit pin or 6 digit pin only

  Future<VonageVerifyResponse> verify({required number, required brand, required code_length}) async {
    try{
      final client = http.Client();
      Uri url = Uri.parse("$_baseurl/verify/json");
      final res = await client.post(url,
          headers:_headers,
          body: jsonEncode(<String, dynamic>{
            'api_key': api_key,
            'api_secret':api_secret,
            'number': number,
            'brand': brand,
            'code_length': code_length
      }));
      if (res.statusCode == 200) {
        return VonageVerifyResponse.fromJson(json.decode(res.body));
      } else {
        throw Exception('STATUS CODE  NOT 200');
      }
    }catch(err){
      throw "Unable to Send Request. Error: $err";
    }
  }

  /// Send a VerifyCheck request to the nexmo API
  /// This will check the code as per request_id
  /// [string] request_id == max length 32
  /// [string] code == 4 digit code or 6 digit code

  Future<VonageVerifyCheckResponse> check({required request_id, required code}) async {
    try{
      final client = http.Client();
      Uri url = Uri.parse("$_baseurl/verify/check/json");
      final res = await client.post(url,
          headers: _headers,
          body: jsonEncode(<String,dynamic>{
            'api_key':api_key,
            'api_secret':api_secret,
            'request_id':request_id,
            'code':code
          })
      );
      if (res.statusCode == 200) {
        return VonageVerifyCheckResponse.fromJson(json.decode(res.body));
      } else {
        throw Exception('STATUS CODE NOT 200');
      }
    }catch(err){
      throw "Unable to Send Request. Error: $err";
    }
  }
}

class VonageVerifyResponse{
  String? request_id;
  String? status;
  String? error_text;

  VonageVerifyResponse._({this.request_id, this.status,this.error_text});

  factory VonageVerifyResponse.fromJson(Map<String,dynamic> json){
    if(json['status']=="0"){
      return VonageVerifyResponse._(request_id: json['request_id']);
    }
    return VonageVerifyResponse._(error_text: json['error_text']);
  }
}

class VonageVerifyCheckResponse{
  String? request_id;
  String? event_id;
  String? status;
  int? auth_status;
  String? price;
  String? currency;
  String? estimated_price_messages_sent;
  String? error_text;

  VonageVerifyCheckResponse._({this.event_id, this.request_id,this.status, this.currency,this.estimated_price_messages_sent,this.price, this.auth_status, this.error_text});

  factory VonageVerifyCheckResponse.fromJson(Map<String,dynamic> json){
    if(json['status']=="0"){
      return VonageVerifyCheckResponse._(event_id: json['event_id'], auth_status:0,request_id: json['request_id']);
    }
    return VonageVerifyCheckResponse._(error_text: json['error_text'],request_id: json['request_id'],auth_status: 1);
  }

}