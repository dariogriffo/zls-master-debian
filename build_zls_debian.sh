ZIG_VERSION=$1
BUILD_VERSION=$2
ZLS_VERSION=$3
declare -a arr=("bookworm" "trixie" "sid")
for i in "${arr[@]}"
do
  DEBIAN_DIST=$i
  FULL_VERSION=$ZIG_VERSION-${BUILD_VERSION}+${DEBIAN_DIST}_amd64
  docker build . -t zls-master-$DEBIAN_DIST --build-arg ZIG_VERSION=$ZIG_VERSION --build-arg ZLS_VERSION=$ZLS_VERSION --build-arg DEBIAN_DIST=$DEBIAN_DIST --build-arg BUILD_VERSION=$BUILD_VERSION --build-arg FULL_VERSION=$FULL_VERSION
  id="$(docker create zls-master-$DEBIAN_DIST)"
  docker cp $id:/zls-master_$FULL_VERSION.deb - > ./zls-master_$FULL_VERSION.deb
  tar -xf ./zls-master_$FULL_VERSION.deb
done

  
