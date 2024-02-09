import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_riverpod_flutter_app/SignUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://wtoklutwjrqxjdkmxdgf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI"
        "6Ind0b2tsdXR3anJxeGpka214ZGdmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDczNzUwNDEsImV4cCI"
        "6MjAyMjk1MTA0MX0.J-soSpejJ9bnuzj_CDrsjyv5g_SA5Vvdd2EQuLysecw",
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SignUp(),
      debugShowCheckedModeBanner: false,
    );
  }
}


