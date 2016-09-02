#
# xbs-compatible Makefile for pyobjc.
#

#GCC_VERSION := $(shell cc -dumpversion | sed -e 's/^\([^.]*\.[^.]*\).*/\1/')
#GCC_42 := $(shell perl -e "print ($(GCC_VERSION) >= 4.2 ? 'YES' : 'NO')")

GnuNoConfigure      = YES
Extra_CC_Flags      = -no-cpp-precomp -g
Extra_Install_Flags = PREFIX=$(RC_Install_Prefix)

#include $(MAKEFILEPATH)/CoreOS/ReleaseControl/GNUSource.make
include $(MAKEFILEPATH)/CoreOS/ReleaseControl/Common.make

Install_Target      = install

# Automatic Extract & Patch
AEP            = YES
AEP_Project    = $(Project)
AEP_Version    = 2.3.2a0
AEP_ProjVers   = $(AEP_Project)-$(AEP_Version)
AEP_Filename   = $(AEP_ProjVers).tar.gz
AEP_ExtractDir = $(AEP_ProjVers)
AEP_Patches    = parser-fixes.diff float.diff CGFloat.diff pyobjc-core_Modules_objc_selector.m.diff

ifeq ($(suffix $(AEP_Filename)),.bz2)
AEP_ExtractOption = j
else
AEP_ExtractOption = z
endif

# Extract the source.
UNUSED = 02-develop-all.sh PyOpenGL-2.0.2.01 altgraph build-support macholib modulegraph py2app pyobjc pyobjc-metadata pyobjc-website pyobjc-xcode trac-example-plugin
install_source::
ifeq ($(AEP),YES)
	$(TAR) -C $(SRCROOT) -$(AEP_ExtractOption)xof $(SRCROOT)/$(AEP_Filename)
	$(RM) $(SRCROOT)/$(AEP_Filename)
	$(RMDIR) $(SRCROOT)/$(AEP_Project)
	$(MV) $(SRCROOT)/$(AEP_ExtractDir) $(SRCROOT)/$(AEP_Project)
	@set -x && \
	cd $(SRCROOT)/$(Project) && \
	rm -rf $(UNUSED) && \
	for patchfile in $(AEP_Patches); do \
	    patch -p0 -i $(SRCROOT)/patches/$$patchfile || exit 1; \
	done && \
	for patchfile in `find . -name pyobjc-api.h | xargs fgrep -l __LP64__`; do \
	    mv -f $$patchfile $$patchfile.orig && \
	    { unifdef -DCGFLOAT_DEFINED -DNSINTEGER_DEFINED $$patchfile.orig > $$patchfile || [ $$? -ne 2 ]; } || exit 1; \
	done
	ed - $(SRCROOT)/$(Project)/pyobjc-core/setup.py < '$(SRCROOT)/patches/pyobjc-core_setup.py.ed'
	ed - $(SRCROOT)/$(Project)/pyobjc-framework-Cocoa/Lib/Foundation/PyObjC.bridgesupport < '$(SRCROOT)/patches/pyobjc-framework-Cocoa_Lib_Foundation_PyObjC.bridgesupport.ed'
	ed - $(SRCROOT)/$(Project)/pyobjc-framework-Cocoa/Lib/PyObjCTools/Conversion.py < '$(SRCROOT)/patches/pyobjc-framework-Cocoa_Lib_PyObjCTools_Conversion.py.ed'
	ed - $(SRCROOT)/$(Project)/pyobjc-framework-Quartz/Lib/Quartz/CoreGraphics/PyObjC.bridgesupport < '$(SRCROOT)/patches/pyobjc-framework-Quartz_Lib_Quartz_CoreGraphics_PyObjC.bridgesupport.ed'
	@set -x && for z in `find $(SRCROOT)/$(Project) -name \*.py -size 0c`; do \
	    echo '#' > $$z || exit 1; \
	done
	find $(SRCROOT)/$(Project) -name \*.so -print -delete
endif

copysource:
	ditto '$(SRCROOT)' '$(OBJROOT)'

DOCS=/Developer/Documentation/Python/PyObjC
EXAMPLES=/Developer/Examples/Python/PyObjC
EXTRAS=$(shell python -c "import sys, os;print os.path.join(sys.prefix, 'Extras')")

real-install:
	@set -x && \
	cd '$(OBJROOT)/$(Project)' && \
	for pkg in pyobjc-core pyobjc-framework-Cocoa `ls -d pyobjc-framework-* | grep -v pyobjc-framework-Cocoa`; do \
	    cd "$(OBJROOT)/$(Project)/$$pkg" && \
	    ARCHFLAGS="$(RC_CFLAGS) -D_FORTIFY_SOURCE=0" PYTHONPATH="$(DSTROOT)$(EXTRAS)/lib/python/PyObjC" \
	    python setup.py install --home="$(EXTRAS)" --root="$(DSTROOT)" || exit 1; \
	done
	@set -x && cd "$(DSTROOT)$(EXTRAS)/lib/python" && \
	install -d PyObjC && \
	for x in *; do \
	    if [ "$$x" != PyObjC -a "$$x" != PyObjC.pth ]; then \
		if [ -e PyObjC/$$x ]; then \
		    ditto $$x PyObjC/$$x && \
		    $(RMDIR) $$x; \
		else \
		    $(MV) "$$x" PyObjC; \
		fi; \
	    fi || exit 1; \
	done
	cp -f $(Project).txt "$(OSL)/$(Project)-$(AEP_Version).txt"
	cp -f $(Project).partial "$(OSV)/$(Project)-$(AEP_Version).partial"

install-docs:
	$(INSTALL) -d '$(DSTROOT)$(DOCS)'
	@set -x && \
	for e in `find "$(OBJROOT)/$(Project)" -name Doc ! -empty ! -path '*pyobjc-metadata*'`; do \
	    d=`dirname $$e` && \
	    n=`basename $$d` && \
	    case $$n in \
	    pyobjc-core) \
		rsync -rplt $$e/ "$(DSTROOT)$(DOCS)" || exit 1;; \
	    pyobjc-*) \
		b=`echo $$n | sed 's/^.*-//'` && \
		rsync -rplt $$e/ "$(DSTROOT)$(DOCS)/$$b" || exit 1;; \
	    esac \
	done

install-examples:
	$(INSTALL) -d '$(DSTROOT)$(EXAMPLES)'
	@set -x && \
	for e in `find "$(OBJROOT)/$(Project)" -name Examples ! -empty -maxdepth 2`; do \
	    d=`dirname $$e` && \
	    n=`basename $$d` && \
	    case $$n in \
	    pyobjc-core) \
		rsync -rplt $$e/ "$(DSTROOT)$(EXAMPLES)" || exit 1;; \
	    pyobjc-*) \
		b=`echo $$n | sed 's/^.*-//'` && \
		rsync -rplt $$e/ "$(DSTROOT)$(EXAMPLES)/$$b" || exit 1;; \
	    esac \
	done

fix_strip:
	@echo ======== fix verification errors =========
	@echo '=== strip .so files ==='
	@set -x && cd '$(DSTROOT)' && \
	for i in `find . -name \*.so | sed 's,^\./,,'`; do \
	    rsync -R $$i $(SYMROOT) && \
	    $(STRIP) -x $$i || exit 1; \
	done

fix_bogus_files:
	@echo '=== fix bogus_files ==='
	find -d "$(DSTROOT)$(EXAMPLES)" -name '*~.nib' -print -exec rm -rf {} ';'

fix_inappropriate_executables:
	@echo '=== fix inappropriate_executables ==='
	chmod a-x "$(DSTROOT)$(EXAMPLES)/Quartz/Core Graphics/CGRotation/demo.png"

fix_verification-errors: fix_bogus_files fix_inappropriate_executables fix_strip

install:: copysource real-install install-docs install-examples fix_verification-errors
