#!/bin/sh
echo "Executing MSBuild DLL begin command..."
dotnet .tools/sonar/SonarScanner.MSBuild.dll begin /o:"kv" /k:"kv_pg.dat" /d:sonar.cs.vstest.reportsPaths="**/TestResults/*.trx" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.verbose=true /d:sonar.login=${SONAR_TOKEN}
echo "Running build..."
dotnet build pg.dat.sln
echo "Running tests..."
dotnet test pg.dat.test/pg.dat.test.csproj --logger:trx
echo "Executing MSBuild DLL end command..."
dotnet .tools/sonar/SonarScanner.MSBuild.dll end /d:sonar.login=${SONAR_TOKEN}