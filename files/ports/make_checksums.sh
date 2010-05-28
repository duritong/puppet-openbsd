cksum -b -a md5 $1
cksum -b -a rmd160 $1
cksum -b -a sha1 $1
cksum -b -a sha256 $1
echo "SIZE ($1) = `ls -l $1 | awk '{ print $5 }'`"
