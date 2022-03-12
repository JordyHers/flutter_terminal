import 'package:terminal/service/service.dart';
import 'package:terminal/repository/repository.dart';


// ______________________ Constants ___________________
final service = Service();
final repository = Repository();
List<String?> past = [];
List<String> contacts = [];
String text = '';
String ip = '';
String model = '';
String? message;
String? note;

class Strings{
  static final helpText = (
      "\n"
      "Welcome to our "
      "- h --- for help \n"
      "- ls --- display the list of files \n "
      "- clc --- open calculator \n "
      "- cd --- enter a folder \n "
      "- cts --- display contacts \n "
      "- msg --- send message  \n "
      "- not --- take notes \n "
      "- jks --- Find the best jokes ever \n "
      "- clear --- clear terminal \n "
      "- set --- settings of the app \n "
      "- get-m --- display messages\n "
      "- get-n --- display notes \n "
      "\n"
      "____________________________");
  static final contText = ("\n"
      "******************************\n"
      "\n"
      " - James Cataclyst\n"
      " - Tech@Crown \n "
      "- VEctorX \n "
      "- c2TDB\n "
      "- Elevator Fury\n "
      "- FerryTail \n "
      "- @lligator2345 \n "
      "- Textosterone \n "
      "\n"
      "___________________");
  static final setText = ("\n"
      " - PHONE MODEL\n"
      " - CHANGE TEXT COLOR \n"
      " - CHANGE TEXT FONT \n "
      "- CHANGE TEXT SIZE \n "
      "- SET PROFILE\n "
      "- LOG OUT\n "
      "- DARK MODE / LIGHT MODE\n "
      "- HIDDEN FEATURES \n "
      "- ACTIVATE DEVELOPER MODE\n "
      "\n"
      "_____________________");
  static final lsText = ("\n"
      "\n"
      " - APPLICATIONS \n"
      " - IMAGES \n "
      "- VIDEOS \n "
      "- DESKTOP\n "
      "- DOWNLOADS \n "
      "- SHARED\n "
      "\n"
      "_____________________");

  static final cdText = ' > ';
  static final msgText = ' > messages >> SAVED << ';
  static final noteText = ' > notes activated >> SAVED << ';
  static final errorText = 'NO COMMAND FOUND';



  ///_____________UI________________
  static final header = " (　-_･) ︻デ═一 ▸    ¯\\_(ツ)_/¯";
  static final headerText = '-h to get list of commands';




}
