FROM ubuntu:24.04 as build

ARG VERSION=v1.0.0
RUN apt-get update
RUN apt-get install -y g++ cmake doxygen valgrind wget
COPY ./schemavalidator.cpp /
COPY ./rapidjson /rapidjson
COPY ./tclap /tclap
RUN g++ -O3 --std=c++17 -I /rapidjson/include -I /tclap/include/ schemavalidator.cpp -o validator -lstdc++fs

FROM ubuntu:24.04
COPY --from=build /validator /validator
ENTRYPOINT ["/validator"]
