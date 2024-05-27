import 'package:dio/dio.dart';
import '../../blocs/authentication/auth_bloc.dart';

/// Request methods PUT, POST, PATCH, DELETE needs access token,
/// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  AuthBloc authBloc;

  AuthorizationInterceptor({
    required this.authBloc,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// adds the access-token with the header
    /// options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9BEkAFRTKJvmLixeOv1';
    /// options.headers["api-token"]= "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9BEkAFRTKJvmLixeOv1";
    /// options.headers["Authorization"]= "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2E1NTlmZDc2ZWZjM2I2NGM1ZTBlZDE5NzM1YTNiMjFmYzM1YTIxYmQwNjJhMWQ4MmQ5NmNjOWNhMjkxOGQ3YzdiYThjYzM2NGZlNmMzMWMiLCJpYXQiOjE2OTgxNDA4ODEuODk1NjA1LCJuYmYiOjE2OTgxNDA4ODEuODk1NjA3LCJleHAiOjE3MTM5NTIwODEuODU5NjQsInN1YiI6IjI0Iiwic2NvcGVzIjpbXX0.zhpPwM1tB0CRFSx9yHnbfxDXYZLrIyeNr9iucGHp_YUuykZdZRRyzr_SKoNWX1_vA1cj42DwZydlVLY4pPkRCiPcqbqq-C9EvuYgA3MKVxH_MkFpgxlFcRo2mEFaHKA1B9_vJIDc1tADVQ5kB0UDUwQFVNOwxkn7LXwN1ZbMtXzn-NMy2941nneRZdSbderHiYr-iJ62gAtntBux6fdg7gpiqt7o6AHUnuzhxTpmhCdsrYdGBxxKU9MUhSkHZ3tgVqjJlWGYsgFXKXKGtf-n9ftfBoqdDQpDHuiwgq4RL5OVcULhcEnIwjDzFWv2fKRfmW8gq8ZfAP94XqL6BV24PaukrTOBUpW53rYcLQFnYD_24UKZE9d9Y7G4FI_8Ol5uBWIZgOgG2-NSiRSbQ_LfRtBNCObj0hMVSUoKfx4901DP7XZQJcChQ9NUb9UB8shAZbfWdo_8xxQwS066B2hFzv7GJscHBpjTd0wQ6GXWzy371d1uPfV9Nhl5RHv-R3SxeRNQWdR3feciTy5enxOWROQolal22x6OkOZilP9MEahE_e-znFiDuoXFG4UIRWUDvZlHqa-MpEid0VZO5Z3CsnfzVjMk48pWb1FdFWbD06KWPLGvfOHBFOK5NqeBSjXgkgAL6y6jzki3cNUXUM6vKsemQWIgKlry1yLPekmqKcY";
      
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log('onResponse called $response\n');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      authBloc.add(const SessionExpired());
    }

    super.onError(err, handler);
  }
}
