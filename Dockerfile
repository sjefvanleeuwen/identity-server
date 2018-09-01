FROM microsoft/dotnet:2.1-aspnetcore-runtime
ARG source
WORKDIR /
EXPOSE 80
COPY ./ext/identityserver4/host/bin/Debug/netcoreapp2.1/publish .
ENTRYPOINT ["dotnet", "Host.dll"]