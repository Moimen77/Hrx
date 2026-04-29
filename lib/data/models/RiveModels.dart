import 'package:hrx/core/constant/assetsPath.dart';
import 'package:rive/rive.dart';

class riveModels {
  final String src;
  final String title;
  final int pagenum;

  // Rive only
  final String? artboard;
  final String? stateMachineName;
  SMIBool? input;

  // Type
  final bool isRive;

  riveModels({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
    required this.pagenum,
    this.isRive = true,
  });

  set setInput(SMIBool status) {
    input = status;
  }

  static List<riveModels> get models {
    return [
      riveModels(
        src: rivePath,
        artboard: 'HOME',
        title: 'الرئيسية',
        stateMachineName: 'HOME_interactivity',
        pagenum: 0,
      ),
      riveModels(
        src: rivePath2,
        artboard: 'LOADING',
        title: 'الموظفين',
        stateMachineName: 'State Machine 1',
        pagenum: 1,
      ),
      riveModels(
        src: rivePath3,
        artboard: 'GPS',
        title: 'الحضور',
        stateMachineName: 'gps_interactivity',
        pagenum: 2,
      ),
      riveModels(
        src: rivePath2,
        artboard: 'RULES',
        title: 'الأجازات',
        stateMachineName: 'State Machine 1',
        pagenum: 3,
      ),
      riveModels(
        src: rivePath2,
        artboard: 'EXIT',
        title: 'الأذونات',
        stateMachineName: 'state_machine',
        pagenum: 4,
      ),
      riveModels(
        src: 'resources/assets/icons/personal.png',
        artboard: 'New Artboard',
        title: 'السلف',
        stateMachineName: 'State Machine 1',
        pagenum: 5,
        isRive: false,
      ),

      riveModels(
        src: 'resources/assets/icons/money.png',
        artboard: 'LIKE/STAR',
        title: 'الرواتب',
        stateMachineName: 'STAR_Interactivity',
        pagenum: 6,
        isRive: false,
      ),
      riveModels(
        src: 'resources/assets/icons/holidays.png',
        artboard: 'LIKE/STAR',
        title: 'الأجازات الرسمية',
        stateMachineName: 'STAR_Interactivity',
        pagenum: 7,
        isRive: false,
      ),
      riveModels(
        src: rivePath,
        artboard: 'SETTINGS',
        title: 'الأعدادات',
        stateMachineName: 'SETTINGS_Interactivity',
        pagenum: 8,
      ),
    ];
  }
}
