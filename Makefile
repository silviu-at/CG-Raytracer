FILE=skeleton

########
#   Directories
S_DIR=Source
S_DIR_MB=Source/MotionBlur
B_DIR=Build

########
#   Output
EXEC=$(B_DIR)/$(FILE)

# default build settings
CC_OPTS=-c -pipe -Wall -Wno-switch -ggdb -g3 -O3
LN_OPTS=-lX11 -ljpeg  #for sdl_image: -lSDL_image 
CC=g++ -fopenmp -L/usr/X11/lib -I/usr/X11/include #should be replaced with X11 paths for any config

CCBuild=g++ -D CORNELL_BOX -fopenmp -L/usr/X11/lib -I/usr/X11/include #should be replaced with X11 paths for any config

########
#       SDL options
SDL_CFLAGS := $(shell sdl-config --cflags)
GLM_CFLAGS := -I$(GLMDIR)
SDL_LDFLAGS := $(shell sdl-config --libs)

########
#   This is the default action
all:Build


########
#   Object list
#
OBJ = $(B_DIR)/$(FILE).o


########
#   Objects
$(B_DIR)/$(FILE).o : $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CCBuild) $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)


########
#   Main build rule     
Build : $(OBJ) Makefile
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

textures :  $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CC) -D CORNELL_BOX -D TEXTURES_CIMG $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

dof :  $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CC) -D CORNELL_BOX -D cmdDOF -D DOFSamples=15 $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

kdtrees :  $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CC) -D KDTREES $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

mirrors :  $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CC) -D CORNELL_BOX -D MIRRORS $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

softshadows :  $(S_DIR)/$(FILE).cpp $(S_DIR)/SDLauxiliary.h $(S_DIR)/TestModel.h
	$(CC) -D CORNELL_BOX -D SOFTSHADOWS -D SoftShadowsSamples=10 $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)

motionblur : $(S_DIR_MB)/$(FILE).cpp $(S_DIR_MB)/SDLauxiliary.h $(S_DIR_MB)/TestModel.h
	$(CC) -D CORNELL_BOX -D SOFTSHADOWS -D SoftShadowsSamples=10 $(CC_OPTS) -o $(B_DIR)/$(FILE).o $(S_DIR_MB)/$(FILE).cpp $(SDL_CFLAGS) $(GLM_CFLAGS)
	$(CC) $(LN_OPTS) -o $(EXEC) $(OBJ) $(SDL_LDFLAGS)
clean:
	rm -f $(B_DIR)/* 
