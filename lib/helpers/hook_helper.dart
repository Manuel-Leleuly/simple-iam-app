import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useOnInit(VoidCallback action) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => action(),
    );
    return null;
  }, []);
}
