enum BlocStateType { initial, loading, loaded, error }

extension BlocStateTypeX on BlocStateType {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() loaded,
    required T Function() error,
  }) {
    switch (this) {
      case BlocStateType.initial:
        return initial();
      case BlocStateType.loading:
        return loading();
      case BlocStateType.loaded:
        return loaded();
      case BlocStateType.error:
        return error();
    }
  }
}