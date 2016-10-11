export local_dir=$(config local_dir)
export repo_url=$(config repo_url)

echo repo_url: $repo_url
echo local_dir: $local_dir

export q="'";

find $local_dir -maxdepth 1 -mindepth 1 -type d -execdir perl -MFile::Basename \
-e 'my $p = basename(@ARGV[0]); my $svn_repo = $ENV{repo_url}; 
my $q = $ENV{q};
print "let \"i++\"; echo -n \$i. \" \"; cd $ENV{local_dir}/$p && git init; git rm -r ./ --ignore-unmatch -q; ",
" svn export $svn_repo/$p -q --force . && git add ./; git commit -a -m export-from-svn -q; echo \n"' {}  \; \
| bash && echo done
