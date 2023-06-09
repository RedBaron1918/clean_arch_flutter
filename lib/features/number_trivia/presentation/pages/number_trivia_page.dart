import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:learning_clean_architecture/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:learning_clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:learning_clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:learning_clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:learning_clean_architecture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sLocator<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return const SizedBox(width: 20);
                },
              ),
              const SizedBox(height: 20),
              const TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
