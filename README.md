# VisualStudio-Snippets
Personal .snippet files for Visual Studio 2017 and above

Run the following Powershell beauty as admin to install:
    
    rm -Force $env:temp\snippets.zip -ErrorAction Ignore;
    rm -Force "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets\VisualStudio-Snippets-master" -ErrorAction Ignore;
    wget https://github.com/yetanotherchris/VisualStudio-Snippets/archive/master.zip -OutFile $env:temp\snippets.zip; 
    Expand-Archive $env:temp\snippets.zip "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets"; 
    cp "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets\VisualStudio-Snippets-master\*.snippet"  "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets\";  
    rd -Force -Recurse "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets\VisualStudio-Snippets-master\"
