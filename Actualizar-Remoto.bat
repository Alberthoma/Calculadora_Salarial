@echo off
setlocal EnableExtensions

REM ============== CONFIG ==============
set "NUEVA_URL=https://github.com/Alberthoma/Calculadora_Salarial.git"
REM ====================================

title Actualizar remoto de Calculadora_Salarial

cd /d "%~dp0"

echo.
echo === Verificando que Git este instalado ===
where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git no esta instalado o no esta en el PATH.
  pause
  exit /b 1
)

echo.
echo === Comprobando repositorio ===
if not exist ".git" (
  echo [ERROR] Esta carpeta no tiene un repositorio Git todavia.
  pause
  exit /b 1
)

echo.
echo === Remoto actual ===
git remote -v

echo.
echo === Cambiando origin a: %NUEVA_URL% ===
git remote set-url origin "%NUEVA_URL%"
if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo cambiar el remoto.
  pause
  exit /b 1
)

echo.
echo === Remoto actualizado ===
git remote -v

echo.
echo === Listo. Pull.bat y Push.bat ya apuntaran al repositorio renombrado. ===
pause
