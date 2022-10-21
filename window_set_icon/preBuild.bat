@echo off
set dllPath=%~1
set solutionDir=%~2
set projectDir=%~3
set arch=%~4
set config=%~5

echo Running pre-build for %config%

where /q GmlCppExtFuncs
if %ERRORLEVEL% EQU 0 (
	echo Running GmlCppExtFuncs...
	GmlCppExtFuncs ^
	--prefix window_set_icon^
	--cpp "%projectDir%autogen.cpp"^
	--gml "%solutionDir%window_set_icon_23/extensions/window_set_icon/autogen.gml"^
	%projectDir%window_set_icon.cpp
)