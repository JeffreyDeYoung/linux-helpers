#!/bin/zsh
#author: Jeffrey DeYoung
#Use to code format java files per the google style guide.
#Eclipse is required for this script to work; it's basically wrapping an Eclipse command.
#Requires zsh because I don't want to write an if statment for bash.
#
#To use, add to your shells .zshrc or .bashrc file.
#Ex: 
#ECLIPSE_BIN=~/eclipse/java-neon/eclipse/eclipse
#source ~/projects/linux-helpers/codeFormatJava.zsh


function codeFormatJava()
{
	called=$_    
	echo "Performing Java Code Format per Google Style Guide on current directory: `pwd`..."	
	#echo $called
	DIR=$(dirname ${(%):-%x})
	#echo $DIR
	$ECLIPSE_BIN -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -config $DIR/org.eclipse.jdt.core.prefs .
}

#handy alias for calling this
alias javaformat="codeFormatJava"

