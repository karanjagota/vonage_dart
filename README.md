# vonage_dart

Clean Dart Wrapper for Vonage verify API. 

```dart
 void main() async {
 
   final Vonage vonage = Vonage(api_key: "VONAGE_API_KEY", api_secret: "VONAGE_API_SECRET");
   
   final vonageVerifyResponse res = await vonage.verify(number: "XXxxxxxxxx",brand:"BRAND NAME",code_length=4);
   if (res.request_id!=null){ print(res.request_id); }  // return ->  "request_id": "xxxxxxxx" or "error_text": "Error Message"
   else { print(res.error_text); }
   
   final vonageVerifyCheckResponse resp = await vonage.check(request_id:"xxx", code:"xxxx");
   if(resp.event_id!=null){ print(resp.event_id); } // returns -> event_id or error_text 
   else { print(resp.error_text); }
   
 }
```

Open an issue if you find any problem running the flutter app or the dart wrapper code. Note- This wrapper is very much limited to app Phone Verification usage.


