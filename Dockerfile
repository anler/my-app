FROM java:8-alpine
MAINTAINER Your Name <you@example.com>

ADD target/uberjar/my-app.jar /my-app/app.jar

EXPOSE 3000

CMD ["sh", "-c", "java -Ddatabase.url=\"postgresql://$RDS_HOSTNAME/$RDS_DB_NAME?user=$RDS_USERNAME&password=$RDS_PASSWORD\" -jar /my-app/app.jar"]
