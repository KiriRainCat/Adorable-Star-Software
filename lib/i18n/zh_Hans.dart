const Map<String, String> zh_Hans = {
  ..._words,
  ..._phrases,
  ..._segments,
};

const Map<String, String> _words = {
  "notification": "通知",
  "login": "登录",
  "username": "用户名",
  "email": "邮箱",
  "password": "密码",
  "register": "注册",
  "validationCode": "验证码",
  "length": "长度",
  "send": "发送"
};

const Map<String, String> _phrases = {
  "noAccountYet": " 还没有账号？",
  "alreadyHasAccount": "已经有账号了？",
  "passwordDoesNotMatch": "密码不匹配",
  "emailInvalid": "邮箱格式错误",
};

const Map<String, String> _segments = {
  "cantBeEmpty": "不能为空",
  "cantBeLessThan": "不能小于",
  "mustEqualTo": "必须等于",
};
