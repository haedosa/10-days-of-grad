datadir=data
trainset=train-images-idx3-ubyte
trainlab=train-labels-idx1-ubyte
testset=t10k-images-idx3-ubyte
testlab=t10k-labels-idx1-ubyte
url=http://yann.lecun.com/exdb/mnist

mkdir -p $datadir
echo "Attempting to download MNIST data"
curl -o $datadir/$trainset.gz $url/$trainset.gz
curl -o $datadir/$trainlab.gz $url/$trainlab.gz
curl -o $datadir/$testset.gz $url/$testset.gz
curl -o $datadir/$testlab.gz $url/$testlab.gz

