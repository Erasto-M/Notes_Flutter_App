import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final nameControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final emailControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final passWordControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final confirmPasswordControllerProvider =
    StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final isLoadingProvider = StateProvider<bool>((ref) => false);

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formkey = GlobalKey<FormState>();
    Future<void> createUser({
      required String email,
      required String password,
    }) async {
      try {
        final user = Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account Created Successfully")));
        }
      } catch (e) {
        print(e);
      }
    }

    final nameController = ref.watch(nameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passWordControllerProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordControllerProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(child: Text("SignUp")),
              showHeight(),
              Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Name cannot be empty";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  showHeight(),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Email cannot be empty";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  showHeight(),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Password cannot be empty";
                      } else if (value.length < 6) {
                        return "passwords should be atleast six characters";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "password",
                    ),
                  ),
                  showHeight(),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Please confirm your password";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      } else if (value.length < 6) {
                        return "passwords should be atleast six characters";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Confirm password",
                    ),
                  ),
                  showHeight(),
                  isLoading
                      ? const SizedBox(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              ref.read(isLoadingProvider.notifier).state = true;
                              await createUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                              ref
                                  .read(nameControllerProvider.notifier)
                                  .state
                                  .clear();
                              ref
                                  .read(emailControllerProvider.notifier)
                                  .state
                                  .clear();
                              ref
                                  .read(passWordControllerProvider.notifier)
                                  .state
                                  .clear();
                                  ref
                                  .read(confirmPasswordControllerProvider.notifier)
                                  .state
                                  .clear();
                              ref.read(isLoadingProvider.notifier).state =
                                  false;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          )),
                ]),
              ),
            ]),
      ),
    );
  }

  SizedBox showHeight() {
    return const SizedBox(
      height: 20,
    );
  }
}
