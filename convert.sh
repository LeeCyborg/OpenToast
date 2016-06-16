IMAGE_NAME=$1
OUTPUT_IMAGE="$IMAGE_NAME.gif"
FINAL_IMAGE_LOCATION="/Volumes/Member_Files/toast" # TODO change

/usr/local/bin/convert -colors 2 $IMAGE_NAME.png $OUTPUT_IMAGE

echo "converted image $IMAGE_NAME"

mv $OUTPUT_IMAGE $FINAL_IMAGE_LOCATION