@ECHO OFF
cd C:\Users\Sam\Documents\LOVE2D\thing\moon
echo $$BUILD STARTING$$
moonc -t C:\Users\Sam\Documents\LOVE2D\thing *.moon
cd ents
moonc -t C:\Users\Sam\Documents\LOVE2D\thing\ents *.moon
cd ..
echo $$BUILD DONE$$