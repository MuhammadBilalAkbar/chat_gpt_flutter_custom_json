class ResponseModel {
  ResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.systemFingerprint,
  });

  final String? id;
  static const String idKey = "id";

  final String? object;
  static const String objectKey = "object";

  final int? created;
  static const String createdKey = "created";

  final String? model;
  static const String modelKey = "model";

  final List<Choice> choices;
  static const String choicesKey = "choices";

  final Usage? usage;
  static const String usageKey = "usage";

  final String? systemFingerprint;
  static const String systemFingerprintKey = "system_fingerprint";


  factory ResponseModel.fromJson(Map<String, dynamic> json){
    return ResponseModel(
      id: json["id"],
      object: json["object"],
      created: json["created"],
      model: json["model"],
      choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
      usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      systemFingerprint: json["system_fingerprint"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "model": model,
    "choices": choices.map((x) => x.toJson()).toList(),
    "usage": usage?.toJson(),
    "system_fingerprint": systemFingerprint,
  };

  @override
  String toString(){
    return "$id, $object, $created, $model, $choices, $usage, $systemFingerprint, ";
  }
}

class Choice {
  Choice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  final int? index;
  static const String indexKey = "index";

  final Message? message;
  static const String messageKey = "message";

  final dynamic logprobs;
  static const String logprobsKey = "logprobs";

  final String? finishReason;
  static const String finishReasonKey = "finish_reason";


  factory Choice.fromJson(Map<String, dynamic> json){
    return Choice(
      index: json["index"],
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      logprobs: json["logprobs"],
      finishReason: json["finish_reason"],
    );
  }

  Map<String, dynamic> toJson() => {
    "index": index,
    "message": message?.toJson(),
    "logprobs": logprobs,
    "finish_reason": finishReason,
  };

  @override
  String toString(){
    return "$index, $message, $logprobs, $finishReason, ";
  }
}

class Message {
  Message({
    required this.role,
    required this.content,
  });

  final String? role;
  static const String roleKey = "role";

  final String? content;
  static const String contentKey = "content";


  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      role: json["role"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
  };

  @override
  String toString(){
    return "$role, $content, ";
  }
}

class Usage {
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  final int? promptTokens;
  static const String promptTokensKey = "prompt_tokens";

  final int? completionTokens;
  static const String completionTokensKey = "completion_tokens";

  final int? totalTokens;
  static const String totalTokensKey = "total_tokens";


  factory Usage.fromJson(Map<String, dynamic> json){
    return Usage(
      promptTokens: json["prompt_tokens"],
      completionTokens: json["completion_tokens"],
      totalTokens: json["total_tokens"],
    );
  }

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "completion_tokens": completionTokens,
    "total_tokens": totalTokens,
  };

  @override
  String toString(){
    return "$promptTokens, $completionTokens, $totalTokens, ";
  }
}
