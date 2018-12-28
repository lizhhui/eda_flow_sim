#!/bin/csh
if($1 == "")then
svn di
else
set prevision = `echo $1-1 |bc`
svn di -r ${prevision}:$1 
endif
