@ECHO OFF
cd C:\Users\Sam\Documents\love\madmoon\moon
echo $$BUILD STARTING$$
moonc -t C:\Users\Sam\Documents\love\madmoon\ *.moon
cd ent
moonc -t C:\Users\Sam\Documents\love\madmoon\ent *.moon
cd ..
cd lib
moonc -t C:\Users\Sam\Documents\love\madmoon\lib *.moon
cd ..
echo $$BUILD DONE$$
cls
love --console C:\Users\Sam\Documents\love\madmoon