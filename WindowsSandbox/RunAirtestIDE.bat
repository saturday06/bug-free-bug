rem なぜかAirtestIDE 1.2.13は、環境変数でAIRTESTIDE_OPENGL=angleとしないと起動しない
setlocal
set AIRTESTIDE_OPENGL=angle
start /b "" "%TEMP%\B3D-VRM-Test\AirtestIDE\AirtestIDE.exe"
endlocal
