echo 'Running rebuild.sh'

fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
