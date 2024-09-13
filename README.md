# IDM-Host-Manager
IDM Host Manager is a utility script for Windows that blocks IDM-related domains, hides invalid serial numbers from IDM servers, and manages the `hosts` file to prevent unauthorized changes.

## Features
- Block IDM-related domains
- Hide invalid serial numbers from IDM servers
- Set `hosts` file to read-only
- Restore default access to `hosts` file
- Check domain blocking status

## Usage
1. Download or clone the repository.
2. Run the script as an administrator.
3. Follow the on-screen menu.
# IDM Host Manager

This script helps manage the `hosts` file to block IDM-related domains and prevent unauthorized changes by IDM. Follow the steps below to activate IDM with a fake serial number, block domains, verify the blocks, and protect the `hosts` file from modifications.

## Prerequisites

- Make sure you have Internet Download Manager (IDM) installed.
- 
## Usage Instructions

1. **Activate IDM with IDM-Activation-Script**

   - Open PowerShell as Administrator:
     - Search for “PowerShell” in the Start menu.
     - Right-click on "Windows PowerShell" and select “Run as administrator”.

   - Run the following command to activate IDM with IDM-Activation-Script:
     ```powershell
     irm https://massgrave.dev/ias | iex
     ```

   - **Credit**: Activation script sourced from [IDM Activation Script](https://github.com/WindowsAddict/IDM-Activation-Script).

2. **Download and Run the IDM Host Manager Script**

   **a. Download the Script:**
   - Download the `IDM_Host_Manager.cmd` script from the [GitHub repository](https://github.com/shotanshu/IDM-Host-Manager).

   **b. Run the Script with Administrator Rights:**
   - Right-click on the downloaded `IDM_Host_Manager.cmd` file and select “Run as administrator”.
   - Follow the on-screen instructions to:
     - Block IDM-related domains.
     - Check if domains are blocked.
     - Set the `hosts` file to read-only to prevent modifications.

## Notes

- **Security**: Ensure you trust and understand the script before running it.
- **Reminder**: It is advisable to purchase a genuine license from the provider for legal and security reasons..
- **Troubleshooting**: If you encounter issues, make sure you are running the script with administrator privileges and that the `hosts` file is not already set to read-only.

For more details and updates, refer to the [GitHub repository](https://github.com/shotanshu/IDM-Host-Manager).

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
