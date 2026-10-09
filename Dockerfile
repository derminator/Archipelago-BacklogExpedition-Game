FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
WORKDIR /src
COPY BEx.Web/BEx.Web.csproj BEx.Web/
COPY BEx.Core/BEx.Core.csproj BEx.Core/
RUN dotnet restore BEx.Web/BEx.Web.csproj
COPY BEx.Web/ BEx.Web/
COPY BEx.Core/ BEx.Core/
RUN dotnet publish BEx.Web/BEx.Web.csproj -c Release -o /app/publish --no-restore --self-contained false

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
RUN groupadd --gid 1000 appuser && useradd --uid 1000 --gid 1000 --create-home appuser \
    && mkdir -p /mnt/data-protection \
    && chown 1000:1000 /mnt/data-protection
COPY --from=builder /app/publish/ ./
ENV ASPNETCORE_ENVIRONMENT=Production ASPNETCORE_URLS=http://+:8080
USER 1000:1000
EXPOSE 8080
ENTRYPOINT ["dotnet", "BEx.Web.dll"]
