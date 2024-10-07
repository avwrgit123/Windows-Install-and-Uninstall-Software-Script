# Windows Install and Uninstall Software Script

function Check-Winget {
    try {
        # Check if winget is installed
        $wingetVersion = winget --version
        Write-Host "winget is installed. Version: $wingetVersion" # Purpose: This cmdlet is used to display messages or output directly to the console. It is useful for providing feedback to the user.
    } catch {
        # Purpose: catch is part of the try-catch error handling structure in PowerShell. It is used to handle exceptions that occur within the try block.
        Write-Host "winget not found"
        Write-Host "Installing winget..."
        Start-Process "ms-store:" -ArgumentList "ms-windows-store://pdp/?ProductId=9nblggh4nns1"
        exit
    }
}

function Update-Winget {
    Write-Host "Updating winget package manager..."
    try {
        winget upgrade --id Microsoft.Winget.Client *>$null  # Suppress all output
    } catch {
        Write-Host "No update found for winget. winget is up to date." # Purpose: This cmdlet is used to display messages or output directly to the console. It is useful for providing feedback to the user.
    }
}

function Show-Menu {
    Write-Host "Script options: Choose one of the options below by selecting a number."
    Write-Host "1. Install software"
    Write-Host "2. Uninstall software"
    Write-Host "3. Uninstall software with no trace"
    Write-Host "4. Exit Menu"
}

function Install-Software {
    $software = Read-Host "What software do you want to install?" # Purpose: This cmdlet is used to prompt the user for input. It reads a line of input from the console and returns it as a string.
    Write-Host "Searching for the software..."
    winget search $software

    $installChoice = Read-Host "Enter the exact name of the software to install:" # Purpose: This cmdlet is used to prompt the user for input. It reads a line of input from the console and returns it as a string.
    winget install "$installChoice"
}

function Uninstall-Software {
    Write-Host "Uninstall software"
    Write-Host "Listing installed software..."
    winget list
    $software = Read-Host "What software do you want to uninstall?" # Purpose: This cmdlet is used to prompt the user for input. It reads a line of input from the console and returns it as a string.
    winget uninstall "$software"
}

function Uninstall-SoftwareNoTrace {
    Write-Host "Uninstall software with no trace"
    Write-Host "Listing installed software..."
    winget list
    $software = Read-Host "What software do you want to uninstall with no trace?" # Purpose: This cmdlet is used to prompt the user for input. It reads a line of input from the console and returns it as a string.
    winget uninstall --purge "$software"
}

function Main {
    Check-Winget
    Update-Winget

    do {
        Show-Menu
        $choice = Read-Host "Enter your choice" # Purpose: This cmdlet is used to prompt the user for input. It reads a line of input from the console and returns it as a string.

        switch ($choice) {
            '1' { Install-Software }
            '2' { Uninstall-Software }
            '3' { Uninstall-SoftwareNoTrace }
            '4' { 
                Write-Host "Exiting the system. Goodbye!" # Purpose: This cmdlet is used to display messages or output directly to the console. It is useful for providing feedback to the user.
                exit
            }
            default { Write-Host "Invalid option. Please try again." } # Purpose: This cmdlet is used to display messages or output directly to the console. It is useful for providing feedback to the user.
        }
    } while ($true)
}

# Run the main function
Main
