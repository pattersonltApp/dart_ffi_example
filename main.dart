import 'dart:ffi';
import 'dart:io' show Directory, Platform;

// C function prototypes
typedef work_func = Int32 Function();
typedef WorkFunc = int Function();

void main() async {
  // Load the dynamic library
  final dylib = DynamicLibrary.open(_getDynamicLibraryPath());

  // Lookup the function
  final workPointer = dylib.lookupFunction<work_func, WorkFunc>('work');

  while (true) {
    await Future.delayed(Duration(seconds: 2));
    final result = workPointer();
    print('Counter value: $result');
  }
}

String _getDynamicLibraryPath() {
  final scriptDir = Directory.current.path;
  print('Script dir: $scriptDir');
  if (Platform.isWindows) {
    print('Windows: $scriptDir\\libcounter.dll');
    return '$scriptDir\\libcounter.dll';
  } else if (Platform.isMacOS) {
    return '$scriptDir/libcounter.dylib';
  } else {
    return '$scriptDir/libcounter.so';
  }
}
