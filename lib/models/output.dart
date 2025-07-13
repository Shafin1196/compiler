
class OutputResult {
  final String language;
  final String version;
  final RunResult run;
  final CompileResult compile;

  OutputResult({
    required this.language,
    required this.version,
    required this.run,
    required this.compile,
  });

  factory OutputResult.fromJson(Map<String, dynamic> json) {
    return OutputResult(
      language: json['language'] as String,
      version: json['version'] as String,
      run: RunResult.fromJson(json['run'] as Map<String, dynamic>),
      compile: CompileResult.fromJson(json['compile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'version': version,
      'run': run.toJson(),
      'compile': compile.toJson(),
    };
  }
}

class RunResult {
  final String stdout;
  final String stderr;
  final int code;
  final dynamic signal;
  final String output;

  RunResult({
    required this.stdout,
    required this.stderr,
    required this.code,
    this.signal,
    required this.output,
  });

  factory RunResult.fromJson(Map<String, dynamic> json) {
    return RunResult(
      stdout: json['stdout'] as String,
      stderr: json['stderr'] as String,
      code: json['code'] as int,
      signal: json['signal'],
      output: json['output'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stdout': stdout,
      'stderr': stderr,
      'code': code,
      'signal': signal,
      'output': output,
    };
  }
}

class CompileResult {
  final String stdout;
  final String stderr;
  final int code;
  final dynamic signal;
  final String output;

  CompileResult({
    required this.stdout,
    required this.stderr,
    required this.code,
    this.signal,
    required this.output,
  });

  factory CompileResult.fromJson(Map<String, dynamic> json) {
    return CompileResult(
      stdout: json['stdout'] as String,
      stderr: json['stderr'] as String,
      code: json['code'] as int,
      signal: json['signal'],
      output: json['output'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stdout': stdout,
      'stderr': stderr,
      'code': code,
      'signal': signal,
      'output': output,
    };
  }
}
