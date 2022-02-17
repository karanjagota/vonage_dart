# vonage_dart

Dart Wrapper around Vonage verify API. 

```dart
 void main() async {
   final Vonage vonage = Vonage(api_key: "VONAGE_API_KEY", api_secret: "VONAGE_API_SECRET");
   final vonageVerifyResponse res = await vonage.verify(number: "XXxxxxxxxx",brand:"BRAND NAME",code_length=4);
   print(res.request_id); // returns ->  "request_id": "xxxxxxxx"
   final vonageVerifyCheckResponse resp = await vonage.check(request_id:"xxx", code:"xxxx");
   print(resp.event_id); // returns -> event_id
 }
```

