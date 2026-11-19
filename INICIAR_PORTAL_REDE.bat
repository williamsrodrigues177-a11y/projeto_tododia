@echo off
setlocal
set "PROJECT_ROOT=%~dp0"
set "AUTH_FILE=%PROJECT_ROOT%deploy\auth\tododia.htpasswd"

where docker >nul 2>&1
if errorlevel 1 goto docker_missing

docker info >nul 2>&1
if errorlevel 1 goto docker_not_running

if not exist "%AUTH_FILE%" goto auth_missing
for %%F in ("%AUTH_FILE%") do if %%~zF EQU 0 goto auth_missing

docker compose -f "%PROJECT_ROOT%deploy\compose.yaml" up --build -d
if errorlevel 1 goto deploy_failed

echo.
echo Portal iniciado na porta 8081.
echo Neste computador: http://localhost:8081/
echo Para acessar de outro dispositivo, use o IPv4 desta maquina:
ipconfig | findstr /i "IPv4"
echo.
echo Compartilhe o endereco somente com usuarios autorizados na rede local.
pause
exit /b 0

:docker_missing
echo Docker nao foi encontrado. Instale e inicie o Docker Desktop e tente novamente.
goto failed

:docker_not_running
echo O Docker nao esta em execucao. Inicie o Docker Desktop e tente novamente.
goto failed

:auth_missing
echo Arquivo de credenciais ausente ou vazio:
echo %AUTH_FILE%
echo Crie deploy\auth\tododia.htpasswd conforme docs\IMPLANTACAO_VM.md.
goto failed

:deploy_failed
echo Falha ao iniciar o portal. Confira as mensagens do Docker Compose acima.
goto failed

:failed
pause
exit /b 1
