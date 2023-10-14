##
# tism
#
# @file
# @version 0.1
SRCS = desk

FULL = full-desk

.PHONY: clean phony

$(FULL):
	mkdir -p full-desk
	peru sync -v
	lensa 'hood' "+hood/commit %$(project)"
	lensa 'hood' "+hood/revive %$(project)"

clean: $(FULL)
	rm -rf $<

build: .peru/lastimports
	cp -r $(SRCS)/* $(FULL)

install: build .peru/lastimports
	cp -rf full-desk/* $(piers)/$(pier)/$(project)
	lensa 'hood' "+hood/commit %$(project)"
	lensa 'hood' "+hood/revive %$(project)"

.peru/lastimports: phony
	peru sync -v

phony:

# end
