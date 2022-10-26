cd /d %~dp0

rd /s/q bin

md bin

copy third\win64\frameless\release\*.dll  bin /y

copy third\win64\glog\release\*.dll  bin /y

copy third\win64\qolm\release\*.dll  bin /y

copy third\win64\openssl\*.dll  bin /y

pause
 