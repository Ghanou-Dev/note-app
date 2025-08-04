import 'package:flutter_test/flutter_test.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_cubit.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_state.dart';

void main() {
  group('test add not method', () {
    // verefy initial state
    test('test inital state of BottomSheetCubit', () {
      final bottomSheetCubit = BottomSheetCubit();
      expect(bottomSheetCubit.state.runtimeType, BottomSheetInitial);
    });
    
  });
}
