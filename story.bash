export local_dir=$(config local_dir)
export svn_repo=$(config svn_repo)
export project=$(config project)
skip_init=$(config skip_init)

echo svn_repo: $svn_repo
echo local_dir: $local_dir

echo

test -d $local_dir || mkdir -p $local_dir

if test -z $skip_init; then

  echo 'initialaze local_dir ... '

  echo 'updating project list from svn_repo ...'

  for i in $(svn list $svn_repo| grep '/'); do 
    mkdir -p $local_dir/$i
  done

else

  echo 'skip initialazation stage ...'
  

fi

echo
echo
echo

find $local_dir -maxdepth 1 -mindepth 1 -type d -execdir perl -MFile::Basename \
-e '

my $p = basename(@ARGV[0]); 
my $svn_repo = $ENV{svn_repo}; 
my $project = $ENV{project};
my $local_dir = $ENV{local_dir};

if ($project){
    exit unless $project eq $p;
}

print "
let \"i++\"; \\
( \\
echo -n \$i. \" \";  \\
mkdir -p $local_dir/$p && \\
cd $local_dir/$p && git init; git rm -r ./ --ignore-unmatch -q && \\
svn export $svn_repo/$p -q --force . \\
&& git add ./ && git commit -a -m export-from-svn ; ) & \\
echo \n"' {}  \; | bash && echo done
