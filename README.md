[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=17975745)
# Deploying a sql-server for developing


Open Terminal and execute this code  
```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Gestion8.0" -e "MSSQL_PID=Developer" -p 1433:1433 -d mcr.microsoft.com/mssql/server:latest
```

We are using docker for deploying a SQL Server, Developer edition from an Microsoft image. Using SQL Authentication, the user ```sa``` and ```Gestion8.0``` as password. 

This server is not persistent, so databases created are lost on container stop.

