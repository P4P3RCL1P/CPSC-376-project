# CPSC-376-project

Installing Emacs
•	Preface: The scope of this section will be to inform the user on how to setup GNU Emacs and format it in a way that is acceptable for running our project. Emacs is an open-source text editor similar to vi and supports the use of Emacs Lisp, a scripting language which can be used to customize and extend the features of Emacs. Our project does not focus on this part of the language, but rather focuses on manipulating the language to execute a certain task. 
•	To get started navigate to the download site for Emacs:
https://www.gnu.org/software/emacs/
•	You will be presented with various download options depending on your operating system. Our group focused on the Windows installation but you could search instructions for installing the software on a MacOS or Linux device.


•	You will be presented with the option of downloading the application from a nearby GNU mirror; or the main GNU FTP server. Both serve the same end goal for our purpose but for consistency’s sake click on the nearby GNU mirror; 
•	Accessing the GNU mirror will navigate you to a directory of emacs version downloads. This application was built using emacs-27, but can be used by earlier versions of emacs (emacs-26 or newer). Since some of the packages we are using are limited to versions 26 and higher any version older than 26 will cause unnecessary errors. Click on the emacs-27/ directory.

•	Once in the directory, click on the emacs-27.1-i686-installer.exe . This will initiate a request to the ftp server and the contents will be downloaded to your device. Again,for consistency’s sake we are choosing to download the software package this way but you could optionally download the full zip folder. Both methods serve the same purpose.


•	After initiating the download you may receive a warning from Chrome or Windows Defender that this product is untrusted or may be malicious. Click Keep or Run Anyway for each option if prompted. 
•	The setup for Emacs will now initialize and you will be prompted to accept the GNU Public General License. Click I Agree and set the install location for Emacs. By default for windows this is set to your Program Files directory but if you do not have global administrative privileges for your machine you may want to change the installation folder. After choosing your install path click Install. 
 
•	With Emacs installing the contents of its application into your root installation folder you will notice a progress bar. After this progress bar has reached 100% you may click Finish and exit out of the installer. You have now installed Emacs and can begin working with the application. The next section will describe how to run Emacs and open the contents of our project for you to run.
Getting Your Environment Setup
•	If you picked the default install location of C:\Program Files\Emacs you will need to grant administrative privileges to Emacs each time you launch it. Since Emacs is a text editor, you can read and write files to a dedicated path. As Program Files is locked by standard Windows users programs that access the contents of this directory will need to be granted special permissions. There are two methods of doing this:
•	To grant special access manually search for Emacs in your windows search bar and click Run as administrator
 
•	To assign administrative privileges automatically each time you start up the application follow the same process as above but instead of clicking Run as administrator click Open file location. From here right click on the Emacs application and select Preferences. In the properties window navigate to the Shortcut tab and click on Advanced. From the Advanced Properties Menu check the Run as administrator option. Now each time you launch emacs you will be starting it with administrative privileges.
 
•	After applying these steps you are ready to begin loading our project files into Emacs. Head over to the project’s GitHub repository and download the main.el, maze.txt, maze2.txt, and maze3.txt files. Optionally you could copy and paste the contents of these files into Emacs. 
•	Github: https://github.com/P4P3RCL1P/CPSC-376-project
•	Upon launching Emacs you will be presented with the following screen:

 
•	From here, navigate to the File tab and either Visit new File if you are copy & pasting the code, or Open file if you downloaded the files directly. You will need to open the main.el file in order for the program to compile. Expand the main.el buffer at the very bottom of the application in order to display the elisp buffer. Your screen should display the following:
 
•	After replicating this step, you will need to enable the repl for running the program. Emacs has a built in Inferior Emacs Lisp Mode which can be enabled by executing an extended command using the M-X key-binding. To do this make sure your cursor is active in the main.el buffer (the bottom section of the program) and press M-X. You will then be prompted to type a command to be executed. Type ielm and press enter. Your main.el buffer will now change and the buffer will load IELM. As such your application should resemble the following:

 
•	Before you can evaluate anything in your repl you must compile the project. Click on the upper window storing the code. Upon doing so, the navigation bar (containing file, edit, options, and buffers tabs) will change and you should see an Emacs-Lisp tab. Click on that tab and select Evaluate Buffer. 
 
•	After evaluating the buffer you will have access to every variable and method that is defined in our source code.  To start the program, simply type (initializeMaze) in the ielm buffer. The next section will cover the scope of our project and the goal of how the program should perform.
