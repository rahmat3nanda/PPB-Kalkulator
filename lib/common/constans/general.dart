import 'dart:developer';

const kGAppName = "Kalkulator";
const kGPackageName = "id.nesd.kalkulator";
const kGVersionName = "1.0.0";
const kGVersionCode = 1;

String kGLogTag = "[$kGAppName]";
const kGLogEnable = true;

void printLog(dynamic data) {
  if (kGLogEnable) {
    log("[${DateTime.now().toUtc()}]$kGLogTag$data");
  }
}
