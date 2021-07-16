# Disables the listed plans in SKU ENTERPRISEPACK 

# Install MSOnline if needed from PSGallery
Install-Module MSOnline

# Connect to MS Online
Connect-MsolService


# Create license object. After "-DisabledPlans" tag list all plans you want disabled on account(s)
$LO = New-MsolLicenseOptions -AccountSkuId "pathfinderservices:ENTERPRISEPACK" -DisabledPlans POWER_VIRTUAL_AGENTS_O365_P2,KAIZALA_O365_P3,Deskless,FLOW_O365_P2,POWERAPPS_O365_P2,SWAY,YAMMER_ENTERPRISE,MCOSTANDARD

# Import a .csv list of users and create an object for it (a row needs to be named "UserPrincipalName" and contain the principal names)
# (You can download from the O365 admin center)
$MyUsers = Import-Csv -Path "C:\myusers.csv"

# Apply change to all users in .csv file
foreach($user in $MyUsers){
Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName `
    -LicenseOptions $LO
	}
	
#This script does not assign licensing to an account, if an account in the .csv file is not licensed, it will error out

#To see assigned licenses for a specific user (Replace <UPN> with a user
#(Get-MsolUser -UserPrincipalName <UPN>).Licenses.ServiceStatus}