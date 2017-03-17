#!/bin/sh

NEW_LINE=""
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMP_DIR="${BASE_DIR}/temp"

echo "+=========================+"
echo "+  Image Optimizer Setup  +"
echo "+=========================+"

echo ${NEW_LINE}
echo ${NEW_LINE}

echo "Checking requirements..."

if [ ! -x "/usr/bin/git" ]; then
	echo "    - git: is not installed in /usr/bin/git"
	exit 1
else
	echo "    - git: installed in /usr/bin/git"
fi

if [ ! -x "/usr/bin/autoconf" ]; then
	echo "    - autoconf: is not installed in /usr/bin/autoconf"
	exit 1
else
	echo "    - autoconf: installed in /usr/bin/autoconf"
fi

if [ ! -x "/usr/bin/automake" ]; then
	echo "    - automake: is not installed in /usr/bin/automake"
	exit 1
else
	echo "    - automake: installed in /usr/bin/automake"
fi

echo "Done Check."

echo ${NEW_LINE}
echo ${NEW_LINE}

if [ -x "/usr/bin/pngquant" ]; then
	echo "pngquant: installed in /usr/bin/pngquant"

	echo ${NEW_LINE}
	echo ${NEW_LINE}
	echo "Copy File: ln -s /usr/bin/pngquant ${BASE_DIR}/pngquant"

	cp /usr/bin/pngquant ${BASE_DIR}/pngquant
else
	git clone "https://github.com/pornel/pngquant" ${TEMP_DIR}/pngquant
	cd ${TEMP_DIR}/pngquant
	./configure --prefix=${TEMP_DIR}
	make
	make install

	# back to root file
	echo ${NEW_LINE}
	echo ${NEW_LINE}

	echo "Copy File: cp ${TEMP_DIR}/bin/pngquant ${BASE_DIR}/pngquant"
	cp ${TEMP_DIR}/bin/pngquant ${BASE_DIR}/pngquant
fi

if [ ! -f "${BASE_DIR}/pngquant" ]; then
	echo "** Failed to install pngquant **"
	exit 1
fi

chmod +x ${BASE_DIR}/pngquant


if [ -x "/usr/bin/jpegoptim" ]; then
	echo "jpegoptim: installed in /usr/bin/jpegoptim"

	echo ${NEW_LINE}
	echo ${NEW_LINE}
	echo "Copy File: ln -s /usr/bin/jpegoptim ${BASE_DIR}/jpegoptim"

	cp /usr/bin/jpegoptim ${BASE_DIR}/jpegoptim
else
	git clone "https://github.com/tjko/jpegoptim" ${TEMP_DIR}/jpegoptim
	cd ${TEMP_DIR}/jpegoptim
	./configure --prefix=${TEMP_DIR}
	make
	make strip
	make install

	# back to root file
	echo ${NEW_LINE}
	echo ${NEW_LINE}

	echo "Copy File: cp ${TEMP_DIR}/bin/jpegoptim ${BASE_DIR}/jpegoptim"
	cp ${TEMP_DIR}/bin/jpegoptim ${BASE_DIR}/jpegoptim
fi

if [ ! -f "${BASE_DIR}/jpegoptim" ]; then
	echo "** Failed to install jpegoptim **"
	exit 1
fi

chmod +x ${BASE_DIR}/jpegoptim


git clone "https://github.com/pornel/giflossy" ${TEMP_DIR}/giflossy
cd ${TEMP_DIR}/giflossy
if [ ! -f "${TEMP_DIR}/giflossy/configure" ]; then
	autoreconf -i
fi

./configure --prefix=${TEMP_DIR}
make
make install

echo "Copy File: cp ${TEMP_DIR}/bin/gifsicle ${BASE_DIR}/gifsicle"
echo "Copy File: cp ${TEMP_DIR}/bin/gifdiff ${BASE_DIR}/gifdiff"

if [ ! -f "${BASE_DIR}/gifsicle" ]; then
	echo "** Failed to install giflossy **"
	exit 1
fi

chmod +x ${BASE_DIR}/gifsicle


echo "Installed Done. Now clean up..."
rm -rf ${TEMP_DIR}











