@echo off
setlocal EnableExtensions

REM ============== CONFIG ==============
set "REPO_URL=https://github.com/Alberthoma/foresee-web.git"
set "BRANCH=main"
REM ====================================

title Actualizar calculadora-salarial

cd /d "%~dp0"

echo.
echo === Verificando que Git este instalado ===
where git >nul 2>&1
if errorlevel 1 (
  echo ERROR: Git no esta instalado o no esta en el PATH.
  echo Descarga Git desde https://git-scm.com/download/win e instalalo.
  pause
  exit /b 1
)

if exist ".git" (
  echo.
  echo === Repositorio ya existe aqui. Actualizando con git pull ===
  git pull origin %BRANCH%
  if errorlevel 1 (
    echo.
    echo ERROR: No se pudo actualizar. Revisa si tienes cambios locales sin guardar ^(git status^).
    pause
    exit /b 1
  )
) else (
  echo.
  echo === Primera vez: descargando el repositorio en esta carpeta ===
  git init
  git remote add origin "%REPO_URL%"
  git fetch origin %BRANCH%
  if errorlevel 1 (
    echo.
    echo ERROR: No se pudo conectar al repositorio. Revisa tu conexion a internet.
    pause
    exit /b 1
  )
  git checkout -b %BRANCH% origin/%BRANCH%
  if errorlevel 1 (
    echo.
    echo ERROR: No se pudo descargar el contenido del repositorio.
    pause
    exit /b 1
  )
)

echo.
echo === Listo. Esta carpeta ya tiene la ultima version. ===
pause
