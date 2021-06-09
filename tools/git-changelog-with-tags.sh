##!/bin/bash
## Author:Andrey Nikishaev,
## Modifications: Gunnar Lindholm, Patrice Lecharpentier

current_date=`date +"%Y-%m-%d"`
repo_name=`git remote show origin`

date_cmd=""

if [[ $# -gt 0 ]]
then
   date_str=$1
   date_cmd="--after "$date_str
else
   date_cmd="--before "$current_date
fi

if [[ $# -gt 1 ]]
then
   dir_str=$2
else
   dir_str=`pwd`
fi

git_name=`git config --get remote.origin.url`
repo_name=`basename -s .git $git_name`
 
 

# Author:Andrey Nikishaev
echo "CHANGELOG"
echo ----------------------
# Original code
# But missing some release tags (with commit instead of tag)
# See example below
#~ a20f153b9df1c0042c3d82242de1299c696809cb commit	refs/heads/master
#~ a20f153b9df1c0042c3d82242de1299c696809cb commit	refs/remotes/origin/master
#~ c7033eabbb419ddd9d1221a5361396ca88114dbf commit	refs/tags/v0.1.0.9005
#~ bf48fc97d4a2456c0c151f59d2f9cfcd6eaa43ce tag	refs/tags/v0.1
#~ 86c594f9c2776a12bce39700d4f093c666657ad7 tag	refs/tags/v0.1.0.9000
#~ 6e9fec552db1e6a59f11b057f71e8cb2bfc48cfc tag	refs/tags/v0.1.0.9001
#~ 4fe071542457f518c9888baddb8ab95b9d5a5959 tag	refs/tags/v0.1.0.9002
#~ 429e7a56e39b48e78281fadb28407eecc88ab135 tag	refs/tags/v0.1.0.9003
#~ 0f9037599ae3f508ed8ca94b11c0bdac11948f4e tag	refs/tags/v0.1.0.9004
 
#git for-each-ref --sort='*authordate' --format='%(tag)' refs/tags |tac |grep -v '^$' | while read TAG ; do
# replace with git tag only
git tag | tac | while read TAG ; do
     echo
     echo
    if [ $NEXT ];then
        echo '# '${repo_name}" "$NEXT
    else
        echo "# "${repo_name}" Current ("$current_date")"
    fi
    echo
    #GIT_PAGER=cat git log --stat --no-merges --format=" * %s" $TAG..$NEXT
    # added $date_cmd for filtering log with dates 
    GIT_PAGER=cat git log --name-only --oneline --date=short $date_cmd --no-merges --format=" * %s (%ad)" $TAG..$NEXT
    echo
    NEXT=$TAG
done
FIRST=$(git tag -l | head -1)
echo
echo [$FIRST]
#GIT_PAGER=cat git log --stat --no-merges --format=" * %s" $FIRST
GIT_PAGER=cat git log --name-only --oneline $date_cmd --no-merges --format=" * %s (%ad)" $FIRST
