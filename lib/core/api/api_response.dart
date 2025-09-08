class ApiResponse<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;

  ApiResponse.success(this.data)
      : errorMessage = null,
        isSuccess = true;

  ApiResponse.failure(this.errorMessage)
      : data = null,
        isSuccess = false;
}
