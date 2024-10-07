@echo off
echo Windows Install and Uninstall Software Script

:check_winget
winget --version >nul 2>&1
REM >nul 2>&1: This combination means that both standard output and standard error from the command are sent to nul, 
REM effectively silencing any output that the command would normally display in the command prompt.
if errorlevel 1 (
REM In a Windows batch script, if errorlevel is used to check the exit code (also known as the return code or status code) of the last executed command. 
REM The exit code is a numeric value returned by a command to indicate whether it was successful or if it encountered an error.
    echo "winget not found"
    echo "Installing winget..."
    powershell -Command "Start-Process ms-store: -ArgumentList 'ms-windows-store://pdp/?ProductId=9nblggh4nns1'" 
    exit /b
)

:menu
echo.
echo "Updating winget package manager."
winget upgrade --id Microsoft.Winget.Client
echo "Updating package list."
winget upgrade --all

echo "Script options: Choose one of the options below by selecting a number."
echo 1. Install software
echo 2. Uninstall software
echo 3. Uninstall software with no trace
echo 4. Exit Menu
REM is the batch file's way of writing comments. It stands for remark, and anything after REM on the same line will be ignored by the script during execution. It's a way to add explanations or notes for people reading the script, but it doesn't affect the script's functionality
REM set /p: This command is used to set a variable from user input. The /p flag tells the script to prompt the user and wait for their response.
set /p choice="Enter your choice: "

REM Case statement equivalent for Windows batch script
if "%choice%"=="1" goto install
if "%choice%"=="2" goto uninstall
if "%choice%"=="3" goto uninstall_trace
if "%choice%"=="4" goto exit
echo Invalid option. Please try again.
goto menu

:install
echo.
set /p software="What software do you want to install? "
winget search %software%
winget install %software%
goto menu

:uninstall
echo.
set /p software="What software do you want to uninstall? "
winget uninstall %software%
goto menu

:uninstall_trace
echo.
set /p software="What software do you want to uninstall with no trace? "
winget uninstall --purge %software%
goto menu

:exit
echo Exiting the system. Goodbye!
exit

