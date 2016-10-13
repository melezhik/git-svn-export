COLUMNS=80
LINES=24

local_dir=$(config local_dir)
svn_repo=$(config svn_repo)

p=$(story_var project)


cd $local_dir && git svn clone $svn_repo/$p 
cd $local_dir/$p && git svn fetch && git svn rebase && echo $p updated 
