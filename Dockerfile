FROM microsoft/aspnetcore-build:2.0 AS buildnet
WORKDIR /app
COPY ./OidcDebugger/*.csproj ./
COPY ./OidcDebugger/wwwroot /var/www/html
RUN dotnet restore
# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /dist

# build Vue app:
FROM node:erbium-alpine3.9 as buildvue
WORKDIR /src
COPY package.json .
COPY OidcDebugger OidcDebugger
COPY webpack.config.js .
RUN npm install
# webpack build
RUN npm run build

FROM microsoft/aspnetcore-build:2.0 as final
WORKDIR /app
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
#ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS http://+:5000
COPY --from=buildnet /dist .
# copy vue content into .net's static files folder:
COPY --from=buildvue /src /app/wwwroot
EXPOSE 5000
ENTRYPOINT ["dotnet", "OidcDebugger.dll"]