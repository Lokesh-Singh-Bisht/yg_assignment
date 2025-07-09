import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yg_assignment/blocs/course/course_event.dart';
import 'package:yg_assignment/blocs/course/course_state.dart';
import 'package:yg_assignment/services/course_services.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseService courseService;
  CourseBloc(this.courseService) : super(CourseInitial()) {
    on<FetchCourses>(_onFetchCourses);
  }

  Future<void> _onFetchCourses(
    FetchCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await courseService.fetchCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
