cd /d %~dp0

rd /s/q bin

md bin

copy third\win64\frameless\debug\*.dll  bin /y

copy third\win64\glog\debug\*.dll  bin /y

copy third\win64\qolm\debug\*.dll  bin /y

copy third\win64\openssl\*.dll  bin /y

pause
 