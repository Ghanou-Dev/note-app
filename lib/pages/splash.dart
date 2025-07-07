import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String pageRoute = 'splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late List<NoteModel> notes;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await precacheImage(AssetImage('assets/images/logo.png'),context);
      await startSplash();
    });
  }

  Future<void> startSplash() async {
    // .. load data
    context.read<HomeCubit>().fetchAllNotes();
    context.read<DeleteCubit>().fetchAllDeletedNotes();
    context.read<FavorietCubit>().fetchAllFavorietNotes();
    await Future.delayed(3.seconds);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ).animate().fadeOut(delay: 1.seconds, duration: Duration(seconds: 3)),
      ),
    );
  }
}
