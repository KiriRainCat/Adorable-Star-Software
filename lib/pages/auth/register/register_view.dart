import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:adorable_star/constants/constants.dart';
import 'package:adorable_star/pages/auth/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SecondaryBg,
      body: Row(
        children: [
          // 注册表单
          const SizedBox(width: 48),
          SizedBox(
            width: 320,
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("register".tr, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 38),
                  buildTextField("email", 0),
                  const SizedBox(height: 14),
                  buildTextField("username", 1),
                  const SizedBox(height: 14),
                  buildValidationCodeField(),
                  const SizedBox(height: 14),
                  buildPasswordField(),
                  const SizedBox(height: 14),
                  buildPasswordField(isRepeat: true),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Get.back(
                      result: DateTime.now().add(Duration(seconds: controller.codeCoolDown.value)).toString(),
                    ),
                    child: Text("alreadyHasAccount".tr),
                  ),
                  const SizedBox(height: 24),
                  buildRegisterButton(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 48),
          // 右侧背景图
          Expanded(
            child: Image.asset(
              "assets/images/bg.png",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String title, int controllerIndex) {
    return Obx(
      () => Focus(
        onFocusChange: (value) {
          controller.inputFieldFillColors[controllerIndex] = value ? Colors.grey[50] : Colors.grey[200];
          controller.inputOpacities[controllerIndex] = value ? 1 : 0.65;
        },
        child: Opacity(
          opacity: controller.inputOpacities[controllerIndex],
          child: TextFormField(
            key: controller.fieldKeys[controllerIndex],
            controller: controller.textControllers[controllerIndex],
            onChanged: (_) => controller.fieldKeys[controllerIndex].currentState!.validate(),
            validator: (value) => value!.isEmpty
                ? "${title.tr}${"cantBeEmpty".tr}"
                : (title == "email" ? (!value.isEmail ? "emailInvalid".tr : null) : null),
            decoration: InputDecoration(
              filled: true,
              fillColor: controller.inputFieldFillColors[controllerIndex],
              hintText: title.tr,
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

  Widget buildValidationCodeField() {
    return Obx(
      () => Row(
        children: [
          // 输入框
          Expanded(
            child: Focus(
              onFocusChange: (value) {
                controller.inputFieldFillColors[2] = value ? Colors.grey[50] : Colors.grey[200];
                controller.inputOpacities[2] = value ? 1 : 0.65;
              },
              child: Opacity(
                opacity: controller.inputOpacities[2],
                child: TextFormField(
                  key: controller.fieldKeys[2],
                  controller: controller.textControllers[2],
                  onChanged: (_) {
                    final bool valid = controller.fieldKeys[2].currentState!.isValid;
                    controller.isValidationCodeValid.value = valid;
                    if (valid) {
                      controller.fieldKeys[2].currentState!.validate();
                    }
                  },
                  validator: (value) => value!.isEmpty
                      ? "${"validationCode".tr}${"cantBeEmpty".tr}"
                      : (value.length != 6 ? "${"validationCode".tr}${"length".tr}${"mustEqualTo".tr} 6" : null),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: controller.inputFieldFillColors[2],
                    hintText: "validationCode".tr,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: controller.isValidationCodeValid.value ? Colors.grey[400]! : Colors.red[700]!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),

          // 发送验证码按钮
          ElevatedButton(
            onPressed: controller.codeCoolDown.value < 1 ? () => controller.sendValidationCode() : null,
            child: controller.codeCoolDown.value < 1
                ? Text("${"send".tr}${"validationCode".tr}")
                : Text(controller.codeCoolDown.value.toString()),
            style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(18))),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField({bool isRepeat = false}) {
    return Obx(
      () => Focus(
        onFocusChange: (value) {
          controller.inputFieldFillColors[3 + (isRepeat ? 1 : 0)] = value ? Colors.grey[50] : Colors.grey[200];
          controller.inputOpacities[3 + (isRepeat ? 1 : 0)] = value ? 1 : 0.65;
        },
        child: Opacity(
          opacity: controller.inputOpacities[3 + (isRepeat ? 1 : 0)],
          child: TextFormField(
            key: controller.fieldKeys[3 + (isRepeat ? 1 : 0)],
            controller: controller.textControllers[3 + (isRepeat ? 1 : 0)],
            onChanged: (_) => controller.fieldKeys[3 + (isRepeat ? 1 : 0)].currentState!.validate(),
            validator: (value) => value!.length < 6
                ? "${"password".tr}${"length".tr}${"cantBeLessThan".tr} 6"
                : (isRepeat ? (controller.textControllers[3].text == value ? null : "passwordDoesNotMatch".tr) : null),
            obscureText: controller.obscurePassword.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: controller.inputFieldFillColors[3 + (isRepeat ? 1 : 0)],
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

  Widget buildRegisterButton() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue[800]),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18)),
              ),
              onPressed: controller.submitting.value ? null : () => controller.register(),
              child: controller.submitting.value
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                  : Text("register".tr),
            ),
          ),
        ),
      ],
    );
  }
}
