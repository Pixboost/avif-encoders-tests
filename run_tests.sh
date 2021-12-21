#!/bin/bash

MAGICK="/home/dimka/Projects/pixboost/im7/ImageMagick/utilities/magick"

for f in ./originals/*; do
  FILENAME=$(basename "$f")
  NOSUFFIX=${FILENAME%.*}

  LIBAVIF_MAGICK_OUTPUT=$( /bin/time -f "${FILENAME},%e,%x" ${MAGICK} "${f}" -quality 70 -define heic:libavif=true "avif:./libavif/${NOSUFFIX}.avif" 2>&1 )
  LIBAVIF_SIZE=$(stat --printf="%s" "./libavif/${NOSUFFIX}.avif")

  LIBHEIF_MAGICK_OUTPUT=$( /bin/time -f "%e,%x" ${MAGICK} "${f}" -quality 70 -define heic:libavif=false "avif:./libheif/${NOSUFFIX}.avif" 2>&1 )
  LIBHEIF_SIZE=$(stat --printf="%s" "./libheif/${NOSUFFIX}.avif")

  echo "${LIBAVIF_MAGICK_OUTPUT},${LIBAVIF_SIZE},${LIBHEIF_MAGICK_OUTPUT},${LIBHEIF_SIZE}"
done