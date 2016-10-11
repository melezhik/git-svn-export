# SYNOPSIS

Export (multiple) svn repositories into (multiple) git repositories.


# INSTALL

    sparrow plg install git-svn-export


# USAGE

    sparrow plg run git-svn-export \
    --param local_dir=/path/to/local/git/repositories/ \
    --param repo_url=http://my.svn.repo/repo-one


# Parameters

## local_dir

This should be a local path to a directory containing a _local git repositories_

## repo_url

This should be a svn repo URL.

For example:

    --param repo_url=http://my.svn.repo/repo-one

Plugin goes through sub directories located at `local_dir` and fetch svn data using `svn export` command:

    svn export $repor_url/$directory

Where $directory is a name of local directory

Before doing `svn export` all local git data removed by `git rm -r .` command. 
After `svn export` command `git add .` command executed and all data committed into local git repository.
As result we _emulate_ migration from svn repository into local git repository.

A local directory layout should be:

    # local_dir:
    /home/melezhik/repos/

    # foo repository:
    /home/melezhik/repos/foo/ -- svn export $url/foo

    # baz repository:
    /home/melezhik/repos/baz/ -- svn export $url/baz

    so on ...

# Author

Alexey Melezhik

