import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionService {
  /// طلب إذن الموقع مع التعامل مع جميع الحالات
  static Future<LocationPermissionResult> requestLocationPermission() async {
    // التحقق من تفعيل خدمة الموقع
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationPermissionResult(
        granted: false,
        message: 'خدمة الموقع غير مفعلة. يرجى تفعيلها من الإعدادات.',
        status: LocationPermissionStatus.serviceDisabled,
      );
    }

    // طلب إذن الموقع
    PermissionStatus status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      return LocationPermissionResult(
        granted: true,
        message: 'تم منح إذن الموقع بنجاح.',
        status: LocationPermissionStatus.granted,
      );
    } else if (status.isDenied) {
      return LocationPermissionResult(
        granted: false,
        message: 'تم رفض إذن الموقع. يمكنك تفعيله لاحقًا من الإعدادات.',
        status: LocationPermissionStatus.denied,
      );
    } else if (status.isPermanentlyDenied) {
      return LocationPermissionResult(
        granted: false,
        message: 'تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات التطبيق.',
        status: LocationPermissionStatus.permanentlyDenied,
      );
    }

    return LocationPermissionResult(
      granted: false,
      message: 'حدث خطأ أثناء طلب إذن الموقع.',
      status: LocationPermissionStatus.unknown,
    );
  }

  /// التحقق من حالة إذن الموقع الحالية
  static Future<bool> isLocationPermissionGranted() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  /// فتح إعدادات التطبيق
  static Future<void> openSettings() async {
    await openAppSettings();
  }
}

enum LocationPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  serviceDisabled,
  unknown,
}

class LocationPermissionResult {
  final bool granted;
  final String message;
  final LocationPermissionStatus status;

  LocationPermissionResult({
    required this.granted,
    required this.message,
    required this.status,
  });
}
