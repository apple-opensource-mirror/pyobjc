import sys
import os
import objc
if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise SystemExit, "%s: You must specify the pid of a process to inject InjectBrowserPlugin into" % (sys.argv[0],)
    interp = os.path.abspath('dist/InjectBrowserPlugin.plugin/Contents/MacOS/InjectBrowserPlugin')
    if not os.path.exists(interp):
        if os.spawnl(os.P_WAIT, sys.executable, sys.executable, 'setup.py', 'py2app', '-A'):
            raise SystemExit, "Could not build InjectBrowserPlugin"
    objc.inject(int(sys.argv[1]), interp)
