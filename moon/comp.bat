@ECHO OFF
cd C:\Users\Sam\Documents\love\thing\moon
echo $$BUILD STARTING$$
moonc -t C:\Users\Sam\Documents\love\thing *.moon
cd ents
moonc -t C:\Users\Sam\Documents\love\thing\ents *.moon
cd ..
echo $$BUILD DONE$$