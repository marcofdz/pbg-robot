Configure Robot Framework

* Install Visual Studio Code
    * https://code.visualstudio.com/docs/?dv=osx
* Install Python last version
    * https://www.python.org/downloads/
* Download gecko driver and move to /Library/Frameworks/Python.framework/Versions/3.7/bin
* Open terminal and type the next commands
    * sudo easy_install pip.   
    * alias python=python3
    * alias pip=pip3
    * pip install robot-framework
    * pip install robotframework-faker
    * pip install robotframework-seleniumlibrary==3.0.0a2
    * pip install robotframework-selenium2library
    * pip install robotframework-imaplibrary2
    * pip install robotframework-xvfb
    * pip install robotframework-excellibrary
    * 
* For ImapLibrary:
    * Go to: /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/ImapLibrary/__init__.py
    * Modify this file as: 
        * https://github.com/rickypc/robotframework-imaplibrary/pull/9/files
