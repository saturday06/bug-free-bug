cd "%~dp0"

@echo =============
@echo Running Tests
@echo =============

@rem copy c:\Windows\System32\msvcp140d.dll c:\blender-git\build_windows_x64_vc17_Debug\bin\Debug
@rem copy c:\Windows\System32\vcruntime140d.dll c:\blender-git\build_windows_x64_vc17_Debug\bin\Debug
@rem copy c:\Windows\System32\vcruntime140_1d.dll c:\blender-git\build_windows_x64_vc17_Debug\bin\Debug
@rem copy c:\Windows\System32\ucrtbased.dll c:\blender-git\build_windows_x64_vc17_Debug\bin\Debug

powershell -ExecutionPolicy RemoteSigned .\Lib.ps1
pause
