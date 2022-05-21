# compiler
CC = gcc
# headers dir
IDIR = include
# output dir
BUILDDIR = build

#source dir and files
SRCDIR = src
SRC = $(wildcard $(SRCDIR)/*.c)

#executable
EXEC = main

#default flags
CFLAGS = -Wall -Werror -Wextra -I$(IDIR)

#
# Debug Build config
#
DBGDIR = $(BUILDDIR)/debug
DBGTARGET = $(DBGDIR)/$(EXEC)
DBGOBJDIR = $(DBGDIR)/obj
DBGOBJ = $(patsubst $(SRCDIR)/%.c, $(DBGOBJDIR)/%.o, $(SRC))
DBGFLAGS = $(CFLAGS) -g -O0 -DDEBUG

#
# Release Build config
#
RELDIR = $(BUILDDIR)/release
RELTARGET = $(RELDIR)/$(EXEC)
RELOBJDIR = $(RELDIR)/obj
RELOBJ = $(patsubst $(SRCDIR)/%.c, $(RELOBJDIR)/%.o, $(SRC))
RELFLAGS = $(CFLAGS) -O2

# Dependency files
DEPDIR = build/dep
DEP = $(patsubst $(SRCDIR)/%.c, $(DEPDIR)/%.d, $(SRC))
include $(DEP)


.PHONY: all clean debug prep release remake list 

#default build 
all: prep release

#
# Debug rules
#
debug: $(DBGTARGET)

$(DBGTARGET): $(DBGOBJ)
	$(CC) -o $@ $^ $(DBGFLAGS)

$(DBGOBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(DBGOBJDIR)
	$(CC) -o $@ -c $< $(DBGFLAGS)

$(DEPDIR)/%.d: $(SRCDIR)/%.c
	@mkdir -p $(DEPDIR)
	$(CC) -MM -MT $(DBGOBJDIR)/$*.o $< $(DBGFLAGS) > $@


#
# Release  rules
#
release: $(RELTARGET)

$(RELTARGET): $(RELOBJ)
	$(CC) -o $@ $^ $(RELFLAGS)
	
$(RELOBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(RELOBJDIR)
	$(CC) -o $@ -c $< $(RELFLAGS)
	
$(DEPDIR)/%.d: $(SRCDIR)/%.c
	@mkdir -p $(DEPDIR)
	$(CC) -MM -MT $(RELOBJDIR)/$*.o $< $(RELFLAGS) > $@


#
# Other rules
#
prep:
	@mkdir -p $(DBGDIR) $(RELDIR)
	
remake: clean all

clean:
	rm -rf $(BUILDDIR)

