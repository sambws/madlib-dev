@ECHO OFF
cd C:\Users\Sam\Documents\love\moonmadlib\moon
echo $$BUILD STARTING$$
moonc -t C:\Users\Sam\Documents\love\moonmadlib*.moon
cd ents
moonc -t C:\Users\Sam\Documents\love\moonmadlib\ents *.moon
cd ..
echo $$BUILD DONE$$