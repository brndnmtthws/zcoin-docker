FROM ubuntu

RUN apt-get update \
  && apt-get install -qq -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev software-properties-common git  clang-6.0 \
  && add-apt-repository ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get install -qq -y libdb4.8-dev libdb4.8++-dev libzmq3-dev libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev \
  && git clone --depth=1 https://github.com/zcoinofficial/zcoin \
  && cd zcoin \
  && update-alternatives --install /usr/bin/cc cc /usr/bin/clang-6.0 100 \
  && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-6.0 100 \
  && ./autogen.sh \
  && ./configure --without-gui --without-upnp --disable-tests \
  && make -j3 \
  && make install-strip \
  && cd .. && rm -rf zcoin \
  && apt-get remove -qq -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev qttools5-dev qttools5-dev-tools libprotobuf-dev libqrencode-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev software-properties-common git \
  && rm -rf /var/lib/apt/lists/*

VOLUME ["/root/.zcoin"]
ENTRYPOINT ["/usr/local/bin/zcoind"]
EXPOSE 8168
