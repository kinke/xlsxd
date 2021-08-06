@echo off
setlocal EnableDelayedExpansion

set ARCH=%1

set    WORK_DIR=%~dp0
set INSTALL_DIR=%~dp0\install_dir

cd /d "%WORK_DIR%"
if !errorlevel! neq 0 exit /b !errorlevel!

Rem git clone https://github.com/jmcnamara/libxlsxwriter.git
if exist "%INSTALL_DIR%\libxlsxwriter\lib\%ARCH%\Release\xlsxwriter.lib" (
	echo %ARCH% libxlsxwriter already built
) else (
	echo %ARCH% libxlsxwriter does not exist
	cd libxlsxwriter
	if !errorlevel! neq 0 exit /b !errorlevel!
	mkdir build_%ARCH%
	if !errorlevel! neq 0 exit /b !errorlevel!
	cd    build_%ARCH%
	if !errorlevel! neq 0 exit /b !errorlevel!
	cmake .. -DCMAKE_INSTALL_PREFIX="%INSTALL_DIR%\libxlsxwriter" -DCMAKE_GENERATOR_PLATFORM=%ARCH% -DUSE_STATIC_MSVC_RUNTIME=ON
	if !errorlevel! neq 0 exit /b !errorlevel!

	cmake --build . --config Release --target install
	if !errorlevel! neq 0 exit /b !errorlevel!
)
