import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/pages/auth/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SecondaryBg,
      body: Row(
        children: [
          // 左侧背景图
          Expanded(
            child: Image.asset(
              "assets/images/bg.png",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 登录表单
          const SizedBox(width: 48),
          SizedBox(
            width: 320,
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("login".tr, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 38),
                  buildUsernameField(),
                  const SizedBox(height: 14),
                  buildPasswordField(),
                  const SizedBox(height: 24),
                  TextButton(onPressed: () => controller.toRegister(), child: Text("noAccountYet".tr)),
                  const SizedBox(height: 24),
                  buildLoginButton(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget buildUsernameField() {
    return Obx(
      () => Focus(
        onFocusChange: (value) {
          controller.inputFieldFillColors[0] = value ? Colors.grey[50] : Colors.grey[200];
          controller.inputOpacities[0] = value ? 1 : 0.65;
        },
        child: Opacity(
          opacity: controller.inputOpacities[0],
          child: TextFormField(
            key: controller.fieldKeys[0],
            controller: controller.textControllers[0],
            onChanged: (_) => controller.fieldKeys[0].currentState!.validate(),
            validator: (value) => value!.isEmpty ? "用户名 / 邮箱不能为空" : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: controller.inputFieldFillColors[0],
              hintText: "${"username".tr} / ${"email".tr}",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Obx(
      () => Focus(
        onFocusChange: (value) {
          controller.inputFieldFillColors[1] = value ? Colors.grey[50] : Colors.grey[200];
          controller.inputOpacities[1] = value ? 1 : 0.65;
        },
        child: Opacity(
          opacity: controller.inputOpacities[1],
          child: TextFormField(
            key: controller.fieldKeys[1],
            controller: controller.textControllers[1],
            onChanged: (_) => controller.fieldKeys[1].currentState!.validate(),
            validator: (value) => value!.length < 6 ? "${"password".tr}${"length".tr}${"cantBeLessThan".tr} 6" : null,
            obscureText: controller.obscurePassword.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: controller.inputFieldFillColors[1],
              hintText: "password".tr,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: 4),
                child: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_sharp,
                  ),
                  splashRadius: 0.01,
                  onPressed: () => controller.obscurePassword.value = !controller.obscurePassword.value,
                  focusNode: FocusNode(skipTraversal: true),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue[800]),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18)),
              ),
              onPressed: controller.submitting.value ? null : () => controller.login(),
              child: controller.submitting.value
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                  : Text("login".tr),
            ),
          ),
        ),
      ],
    );
  }
}
