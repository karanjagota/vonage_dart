import 'package:flutter_test/flutter_test.dart';
import 'package:vonage_dart/vonage_dart.dart';
import 'variables.sample.dart';

void main() {
  test('can start verification', () async {
    final vonage = Vonage(api_key: VONAGE_API_KEY,api_secret: VONAGE_API_SECRET);
    final res = await vonage.verify(number: NUMBER, brand: BRAND_NAME, code_length: CODE_LENGTH);
    assert(res is VonageVerifyResponse);
  });

  test('check the code', () async {
    final vonage = Vonage(api_key: VONAGE_API_KEY,api_secret: VONAGE_API_SECRET);
    final res_check = await vonage.check(request_id: REQUEST_ID, code: VALID_CODE);
    assert(res_check is VonageVerifyCheckResponse);
  });

}
