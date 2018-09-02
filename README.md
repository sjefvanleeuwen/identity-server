# Identity-server

This project contains powershell and docker scripts for pulling in IdentityServer from: 
https://github.com/IdentityServer/IdentityServer4

**Do not use the identity server in production, as there is no unique private key and the storage of all the accounts are in volatile memory.**

1. Clones the repo into ext/identityserver
2. Builds the identity server using provider build script
3. publishes the Host project using dotnet publish
4. Builds the docker image.

## Pulling and using the docker cointainer

If you dont want to build your own image, you can pull it from docker.io:

```
docker pull wigo4it/wigo4it/identityserver4:latest
docker run --rm -p 5099:80 wigo4it/identityserver4:latest --environment="Development"
```

## Building the image yourself

```powershell
PS C:\Users\*******\identity-server> .\build.ps1
Cloning into 'ext/identityserver4'...
remote: Counting objects: 22096, done.
remote: Compressing objects: 100% (4/4), done.
Receiving objects: 100% (22096/22096), 9.35 MiB | 2.58 MiB/s, done.2 eceiving objects: 100% (22096/22096), 9.10 MiB | 2.55 MiB/s

Resolving deltas: 100% (15742/15742), done.
Checking out files: 100% (675/675), done.
Preparing to run build script...
Running build script...

========================================
Clean
========================================

========================================
Build
========================================
Microsoft (R) Build Engine version 15.8.166+gd4e8d81a88 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restoring packages for C:\Users\*******\identity-server\ext\identityserver4\src\IdentityServer4.csproj...
  Generating MSBuild file C:\Users\*******\identity-server\ext\identityserver4\src\obj\IdentityServer4.csproj.nuget.g.props.
  Generating MSBuild file C:\Users\*******\identity-server\ext\identityserver4\src\obj\IdentityServer4.csproj.nuget.g.targets.
  Restore completed in 6,38 sec for C:\Users\*******\identity-server\ext\identityserver4\src\IdentityServer4.csproj.
  IdentityServer4 -> C:\Users\*******\identity-server\ext\identityserver4\src\bin\Release\netstandard2.0\IdentityServer4.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:14.91

========================================
Test
========================================

========================================
Pack
========================================
Microsoft (R) Build Engine version 15.8.166+gd4e8d81a88 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restore completed in 87,06 ms for C:\Users\*******\identity-server\ext\identityserver4\src\IdentityServer4.csproj.
  IdentityServer4 -> C:\Users\*******\identity-server\ext\identityserver4\src\bin\Release\netstandard2.0\IdentityServer4.dll
  Successfully created package 'C:/Users/*******/identity-server/ext/identityserver4/artifacts/packages\IdentityServer4.2.3.0-preview1-update1.nupkg'.

========================================
Default
========================================

Task                          Duration
--------------------------------------------------
Clean                         00:00:00.2259030
Build                         00:00:16.5397076
Test                          00:00:00.0046656
Pack                          00:00:05.1906938
--------------------------------------------------
Total:                        00:00:21.9655470
Microsoft (R) Build Engine version 15.8.166+gd4e8d81a88 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restoring packages for C:\Users\*******\identity-server\ext\identityserver4\host\Host.csproj...
  Restore completed in 44,69 ms for C:\Users\*******\identity-server\ext\identityserver4\src\IdentityServer4.csproj.
  Generating MSBuild file C:\Users\*******\identity-server\ext\identityserver4\host\obj\Host.csproj.nuget.g.props.
  Generating MSBuild file C:\Users\*******\identity-server\ext\identityserver4\host\obj\Host.csproj.nuget.g.targets.
  Restore completed in 10,53 sec for C:\Users\*******\identity-server\ext\identityserver4\host\Host.csproj.
  IdentityServer4 -> C:\Users\*******\identity-server\ext\identityserver4\src\bin\Debug\netstandard2.0\IdentityServer4.dll
  Host -> C:\Users\*******\identity-server\ext\identityserver4\host\bin\Debug\netcoreapp2.1\Host.dll
  Host -> C:\Users\*******\identity-server\ext\identityserver4\host\bin\Debug\netcoreapp2.1\Host.Views.dll
  Host -> C:\Users\*******\identity-server\ext\identityserver4\host\bin\Debug\netcoreapp2.1\publish\
Building api
Step 1/6 : FROM microsoft/dotnet:2.1-aspnetcore-runtime
 ---> 251f1045c425
Step 2/6 : ARG source
 ---> Using cache
 ---> 666fcfb0fe37
Step 3/6 : WORKDIR /
 ---> Using cache
 ---> eaab63af692e
Step 4/6 : EXPOSE 80
 ---> Using cache
 ---> 4e097fe00d81
Step 5/6 : COPY ./ext/identityserver4/host/bin/Debug/netcoreapp2.1/publish .
 ---> 74c8a83219bb
Step 6/6 : ENTRYPOINT ["dotnet", "Host.dll"]
 ---> Running in 6784625eb297
Removing intermediate container 6784625eb297
 ---> 42d73acb34d3

Successfully built 42d73acb34d3
Successfully tagged wigo4it/identityserver4:latest
PS C:\Users\*******\identity-server\ext\identityserver4>
```

```
docker run --rm -p 5099:80 wigo4it/identityserver4:latest --environment="Development"
```

You should now be able to see the openid configuration with endpoints for your client implementations:

http://localhost:5099/.well-known/openid-configuration

```json
{
   "issuer":"http://localhost:5099",
   "jwks_uri":"http://localhost:5099/.well-known/openid-configuration/jwks",
   "authorization_endpoint":"http://localhost:5099/connect/authorize",
   "token_endpoint":"http://localhost:5099/connect/token",
   "userinfo_endpoint":"http://localhost:5099/connect/userinfo",
   "end_session_endpoint":"http://localhost:5099/connect/endsession",
   "check_session_iframe":"http://localhost:5099/connect/checksession",
   "revocation_endpoint":"http://localhost:5099/connect/revocation",
   "introspection_endpoint":"http://localhost:5099/connect/introspect",
   "frontchannel_logout_supported":true,
   "frontchannel_logout_session_supported":true,
   "backchannel_logout_supported":true,
   "backchannel_logout_session_supported":true,
   "scopes_supported":[
      "openid",
      "profile",
      "email",
      "custom.profile",
      "api1",
      "api2.full_access",
      "api2.read_only",
      "offline_access"
   ],
   "claims_supported":[
      "sub",
      "name",
      "family_name",
      "given_name",
      "middle_name",
      "nickname",
      "preferred_username",
      "profile",
      "picture",
      "website",
      "gender",
      "birthdate",
      "zoneinfo",
      "locale",
      "updated_at",
      "email",
      "email_verified",
      "location"
   ],
   "grant_types_supported":[
      "authorization_code",
      "client_credentials",
      "refresh_token",
      "implicit",
      "password",
      "custom",
      "custom.nosubject"
   ],
   "response_types_supported":[
      "code",
      "token",
      "id_token",
      "id_token token",
      "code id_token",
      "code token",
      "code id_token token"
   ],
   "response_modes_supported":[
      "form_post",
      "query",
      "fragment"
   ],
   "token_endpoint_auth_methods_supported":[
      "client_secret_basic",
      "client_secret_post",
      "private_key_jwt"
   ],
   "subject_types_supported":[
      "public"
   ],
   "id_token_signing_alg_values_supported":[
      "RS256"
   ],
   "code_challenge_methods_supported":[
      "plain",
      "S256"
   ]
}
```