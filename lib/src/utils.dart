/// bulksmszw api request respond
/// property in [ApiResponse] -> statusresponse
enum SMSRESPONSE {
  /// api response successful
  SUCCESS,

  /// error sending bulksms
  ERROR,

  /// internal error occured,
  FAIL,

  /// api request success but bulksmsapi returns a custom exception
  API_ERROR,
}