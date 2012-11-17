ARGS ?=
TOP = $(shell pwd)
export PYTHONPATH := $(TOP)/enzyme:$(TOP)::$(PYTHONPATH)

.PHONY: dist test desktop shell cluster client

shell:
	rm -f .pystart
	echo "from cv2 import *; from VideoWrapper import *" > .pystart
	PYTHONSTARTUP="./.pystart" python 
	rm -f .pystart

desktop:
	$(TOP)/bin/videoSegmenter ${ARGS}

dist:
	python $(TOP)/setup.py sdist

test:
	python -m unittest discover -p '*Test.py'

gui:
	pyuic4 segmenter/gui.ui -o segmenter/Gui.py

# Test targets
cluster:
	python "$(TOP)/segmenter/FaceClustering.py" res/skyfall.mp4

client:
	python "$(TOP)/segmenter/Client.py" ${ARGS}

