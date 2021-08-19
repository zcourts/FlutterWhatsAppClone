import 'package:artemis/artemis.dart';
import 'package:fwat/models/graphql/graphql.dart';
import 'package:http/http.dart' as http;

class HypiClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    const token =
        'eyJhbGciOiJSUzI1NiJ9.eyJoeXBpLmxvZ2luIjp0cnVlLCJoeXBpLnVzZXJuYW1lIjoiaHlwaUBjcmxvZy5pbmZvIiwiaHlwaS5lbWFpbCI6Imh5cGlAY3Jsb2cuaW5mbyIsImF1ZCI6IjAxRjJDTUpUTjRFNDk3WkQ5WVI1UE1USjdUIiwiaWF0IjoxNjI3NzI3Mzg1LCJleHAiOjE2MzAzMTkzODUsInN1YiI6IjAxRjJDTUpUS1cwRTQ4M1ZZUFdTOUJEV1RZIiwibmJmIjoxNjI3NzI3Mzg1fQ.UXN2V3PDg7k4Gs0pTn2p0qYnJpAn1tQ30fVy95oZYW_8YkBnxjtRiAvdjx0eBeSy29ydR8HlNZYvY9kqpder2PLOeiFeQnRALxZbf4RustcvxPAhRdfhEEAColGmuv051xHEjiWhJhxHMVU_g3sM2vy3D6vdnJV-v6qGPclIqPek26BjAhPaFe-Q_HdTnl_Ctjmw2kGRVm0PMXM3EBydXR3vDmvWXU0IZ3h_rkr-VFIkhkilw9JfmgV62haUojBTMJ0mJM7FbyprTYDVQERMO19N2FCRiIG1gLR31ctUM7BojRkt2HT0UjMw2-_a9_EoC0LUIzp1ivWlBcKJ-QzUjg';
    request.headers['Authorization'] = 'Bearer $token';
    return _inner.send(request);
  }

  void main() async {
    final client = ArtemisClient(
      'https://sleepwalk.apps.hypi.app/graphql',
      httpClient: HypiClient(),
    );

    final query = FindMessagesQuery(variables: FindMessagesArguments(arcql: '*'));
    // final savedMsg = SaveMessagesQueryMutation()

    final response = await client.execute(query);
    client.dispose();

    if (response.hasErrors) {
      return print('Error: ${response.errors?.map((e) => e.message).toList()}');
    }
    (response.data?.find.edges ?? [])
        .map((r) => "Product title is :" + r.node.toJson().toString())
        .forEach(print);
  }
}
