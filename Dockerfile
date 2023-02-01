FROM eclipse-temurin:17-jdk-alpine

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR
ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.71

# 1. Download the latest version of Tomcat 9.0.71.
# 2. Create CATALINA_HOME directory.
# 3. Extract Tomcat 9.0.71 to CATALINA_HOME directory.
# 4. Delete downloaded tar.gz file. 
# 5. Delete the default Tomcat webapps.
# 6. Create the Tomcat webapps folder.
# 7. Create Tomcat Linux user with Tomcat group.
# 8. Change ownership of CATALINA_HOME to Tomcat Linux user.
RUN set -eux; \
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz; \
    mkdir -p "$CATALINA_HOME"; \
    tar xvzf apache-tomcat-9.0.71.tar.gz --strip-components 1 --directory "$CATALINA_HOME"; \
    rm apache-tomcat-9.0.71.tar.gz;\
    rm -rf /usr/local/tomcat/webapps; \
    mkdir /usr/local/tomcat/webapps; \
    adduser -H -D tomcat; \
    chown -R tomcat:tomcat /usr/local/tomcat;

WORKDIR $CATALINA_HOME

# We are not using default Root user to run tomcat.
USER tomcat

# Expose Tomcat's Port 8080.
# - To listen to TLS Port 8443, we need to add TLS library.
EXPOSE 8080

COPY ./helloworld-1.0.0.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]