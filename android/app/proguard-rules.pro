# Mantener todas las clases de io.socket (para la funcionalidad de socket.io)
-keep class io.socket.** { *; }
-dontwarn io.socket.**

# Mantener todas las clases de Flutter (importante para la funcionalidad de Flutter en general)
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.** { *; }

# Mantener todas las clases de com.google.android.play.core (usado por Play Core Library)
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.core.**

# Mantener las anotaciones necesarias para evitar problemas con reflección
-keepattributes *Annotation*

# Mantener todas las clases de la biblioteca nkzawa (parte de socket.io)
-keep class com.github.nkzawa.** { *; }

# Opcional: Mantener las clases relacionadas con FLChart para evitar que se eliminen en el modo release
-keep class com.example.miosense.fl_chart.** { *; }
-keep class com.github.wuxudong.rncharts.** { *; }
