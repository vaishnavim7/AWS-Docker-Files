FROM ubuntu:18.04


# Install Jdk
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean
RUN java -version

# Install Apache Tomcat
RUN apt-get install -y  wget && \
        wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.tar.gz && \
                tar -xvzf apache-tomcat-9.0.40.tar.gz

# Chmod permissions
RUN chmod +x apache-tomcat-9.0.40/bin/startup.sh && \
        chmod +x apache-tomcat-9.0.40/bin/shutdown.sh

# Creating Contex.xml
RUN wget https://demo-aws-s3-bucket.s3.amazonaws.com/context.xml

# Creating war file
RUN wget https://demo-aws-s3-bucket.s3.amazonaws.com/JspHelloApp.war



# Cp command
RUN cp context.xml apache-tomcat-9.0.40/webapps/manager/META-INF/

# Cp command
RUN cp JspHelloApp.war apache-tomcat-9.0.40/webapps


# Test
RUN cat apache-tomcat-9.0.40/webapps/manager/META-INF/context.xml

RUN ls apache-tomcat-9.0.40/webapps/manager/META-INF/context.xml

#Run CMD
CMD ["apache-tomcat-9.0.40/bin/catalina.sh", "run"]



EXPOSE 8080
