@echo off
setlocal EnableExtensions EnableDelayedExpansion

title Subir cambios de Calculadora_Salarial

REM Mensaje de commit por parametro (opcional)
set "COMMIT_MSG=%~1"
if "%COMMIT_MSG%"=="" set "COMMIT_MSG=Actualizacion desde escritorio"

cd /d "%~dp0"

echo.
echo === Verificando Git ===
where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git no esta instalado o no esta en el PATH.
  echo Instala Git desde https://git-scm.com/download/win
  pause
  exit /b 1
)

echo.
echo === Comprobando repositorio ===
if not exist ".git" (
  echo [ERROR] Esta carpeta no tiene un repositorio Git todavia.
  echo Primero ejecuta el .bat de "actualizar" para descargarlo aqui.
  pause
  exit /b 1
)

echo.
echo === Guardando tus cambios locales primero ===
git add -A
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
  echo (No habia cambios nuevos para comitear; se continua por si hay commits pendientes de subir)
)

echo.
echo === Trayendo los ultimos cambios de GitHub ===
git pull --rebase origin main
if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo actualizar. Puede haber un conflicto real entre tus cambios y los de GitHub.
  echo Revisa con "git status" y resuelve el conflicto antes de reintentar.
  pause
  exit /b 1
)

echo.
echo === Subiendo a GitHub ===
git push origin main
if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo hacer push. Si te pide usuario/contrasena, usa tu usuario de GitHub
  echo y un Personal Access Token ^(no tu contrasena normal^) como contrasena.
  pause
  exit /b 1
)

echo.
echo === Listo. Tus cambios ya estan en GitHub. ===
echo Sitio: https://alberthoma.github.io/Calculadora_Salarial/
echo.
pause
