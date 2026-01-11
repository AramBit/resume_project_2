class HomeState {
  HomeState({
    this.numberOfEvent = 0,
    this.numberOfposter = 0,
    this.categoryIndex = 0,
  });
  final int numberOfEvent;
  final int numberOfposter;
  final int categoryIndex;

  HomeState copyWith({
    int? copynumberOfEvent,
    int? copynumberOfposter,
    int? copycategoryIndex,
  }) {
    return HomeState(
      numberOfEvent: copynumberOfEvent ?? numberOfEvent,
      numberOfposter: copynumberOfposter ?? numberOfposter,
      categoryIndex: copycategoryIndex ?? categoryIndex,
    );
  }
}
