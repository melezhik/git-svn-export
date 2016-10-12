export local_dir=$(config local_dir)
export svn_repo=$(config svn_repo)
export project=$(config project)

echo svn_repo: $svn_repo
echo local_dir: $local_dir

find $local_dir -maxdepth 1 -mindepth 1 -type d -execdir perl -MFile::Basename \
-e '

my $p = basename(@ARGV[0]); 
my $svn_repo = $ENV{svn_repo}; 
my $project = $ENV{project};

if ($project){
    exit unless $project eq $p;
}

print "let \"i++\"; echo -n \$i. \" \"; cd $ENV{local_dir}/$p && git init; git rm -r ./ --ignore-unmatch -q; ",
" svn export $svn_repo/$p -q --force . && git add ./; git commit -a -m export-from-svn ; echo \n"' {}  \; \
| bash && echo done
