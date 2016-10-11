export local_dir=$(config local_dir)
export repo_url=$(config repo_url)

echo repo_url: $repo_url
echo local_dir: $local_dir

export q="'";

find $local_dir -maxdepth 1 -mindepth 1 -type d -execdir perl -MFile::Basename \
-e 'my $p = basename(@ARGV[0]); my $svn_repo = $ENV{repo_url}; 
my $q = $ENV{q};
print "let \"i++\"; echo -n \$i. \" \"; cd $ENV{local_dir}/$p && git init 2>/dev/null; git rm -r .; ",
" svn export $svn_repo/$p -f . && git add .; git commit -a -m export-from-svn; echo \n"' {}  \; \
#| bash && echo bitbucket-repo-done
