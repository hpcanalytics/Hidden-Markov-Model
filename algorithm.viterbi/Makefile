fast-mcmc : src/RJ_MCMC.cpp src/SImage.h src/SImageIO.h src/DTwoDimArray.h
	g++ -DSTAND_ALONE -DOPT --fast-math -march=native -O4 -o MCMC src/RJ_MCMC.cpp -I src/ -lpng -ftree-vectorizer-verbose=1
mex : src/RJ_MCMC.cpp src/SImage.h src/SImageIO.h src/DTwoDimArray.h
	g++ -DOPT --fast-math -march=native -O4 -o MCMC src/RJ_MCMC.cpp -I src/ -ftree-vectorizer-verbose=1
mcmc : src/RJ_MCMC.cpp src/SImage.h src/SImageIO.h src/DTwoDimArray.h
	g++ -DSTAND_ALONE --fast-math -march=native -O4 -o MCMC src/RJ_MCMC.cpp -I src/ -lpng -ftree-vectorizer-verbose=1
debug : src/RJ_MCMC.cpp src/SImage.h src/SImageIO.h src/DTwoDimArray.h
	g++ -DSTAND_ALONE -DOPT -DDEBUG -march=native -O4 -o MCMC src/RJ_MCMC.cpp -I src/ -lpng -ftree-vectorizer-verbose=1
clean:
	rm MCMC


