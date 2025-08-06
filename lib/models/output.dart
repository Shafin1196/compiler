class OutputResult {
  final dynamic stdout;
  final dynamic stderr;
  final Map<String, dynamic>? extra;

  OutputResult({required this.stdout, required this.stderr, this.extra});

  factory OutputResult.fromJson(Map<String, dynamic> json) {
    return OutputResult(
      stdout: json['stdout'] as String,
      stderr: json['stderr'] as String,
      extra: json, // Store all data for flexibility
    );
  }
}