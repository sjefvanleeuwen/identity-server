Remove-Item ext/identityserver4 -Recurse -Force
git clone https://github.com/IdentityServer/IdentityServer4 ext/identityserver4
Set-Location ./ext/identityserver4/
# Tests project run the .NET4.6.1 framework, remove them as we target only .NET Core
# And these tests projects will fail on systems that only have core installed.
Remove-Item test -Recurse -Force
./build.ps1
dotnet publish ./host
docker-compose build
