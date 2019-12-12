FROM maven:3.5.2-jdk-8
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
WORKDIR /boxfuse-sample-java-war-hello
RUN mvn package
CMD ["mvn"]