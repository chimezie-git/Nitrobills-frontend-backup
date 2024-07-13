# Nitro Bills

An app for Nitro bills.

*An upwork project*


### Commands
add native splash
```bash
dart run flutter_native_splash:create
```

generate hive box
```bash
dart run build_runner build --delete-conflicting-outputs 
```

generate launcher icon
```bash
dart run flutter_launcher_icons
```

allow adb for local host
```bash
adb reverse tcp:8000 tcp:8000
```


### Hive Boxes
| hive boxes | Type id |
|------------|---------|
|AuthData | 0 |
|DataManagement | 1 |
|DayData | 2 |
|Recent Payment | 3|