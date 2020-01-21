# Comment: Image base with free5GC installed

# Download ubuntu from the Docker Hub
FROM ubuntu:bionic

RUN apt-get update

# Install GO
RUN apt-get -y install software-properties-common git
RUN add-apt-repository ppa:longsleep/golang-backports
RUN apt-get update
RUN apt-get -y install golang-go

# Install GO dependencies
RUN go get -u -v "github.com/gorilla/mux"
RUN go get -u -v "golang.org/x/net/http2"
RUN go get -u -v "golang.org/x/sys/unix"

# Install all the dependencies
RUN apt-get -y install autoconf apt-utils libtool gcc pkg-config git flex bison libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev iproute2 iptables

# Clone the repository
RUN git clone https://bitbucket.org/nctu_5g/free5gc-stage-1.git free5gc
WORKDIR "free5gc/"

# Compile the source
RUN autoreconf -iv
RUN ./configure --prefix=`pwd`/install
RUN rm src/smf/http_server/main.go
COPY main.go src/smf/http_server/main.go
COPY amf.go src/amf/http_server/main.go
RUN make -j `nproc`
RUN make install

# Add configuration files
ADD config /etc/free5gc

ENV MONGODB_STARTUP_TIME 5