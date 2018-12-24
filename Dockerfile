FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /build
ARG VERSION=1.0.0
COPY ./src/ ./
RUN dotnet publish -c Release -o out CptLog.Api.Record/CptLog.Api.Record.csproj -p:Version=${VERSION}

FROM microsoft/dotnet:2.1-runtime
WORKDIR app
EXPOSE 80
COPY --from=build-env /build/CptLog.Api.Record/out ./
ENTRYPOINT ["dotnet", "CptLog.Api.Record.dll"]
