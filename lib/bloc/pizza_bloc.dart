import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tutorial/models/pizza_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    on<LoadPizzaCounter>(
      (event, emit) async {
        await Future.delayed(Duration(seconds: 3));
        emit(
          const PizzaLoaded(pizzas: <Pizza>[]),
        );
      },
    );
    on<AddPizza>(
      (event, emit) {
        if (state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(
            PizzaLoaded(
              pizzas: List.from(state.pizzas)..add(event.pizza),
            ),
          );
        }
      },
    );
    on<RemovePizza>(
      (event, emit) {
        if (state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(
            PizzaLoaded(
              pizzas: List.from(state.pizzas)..remove(event.pizza),
            ),
          );
        }
      },
    );
  }
}
