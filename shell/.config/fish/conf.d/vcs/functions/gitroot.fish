function gitroot --description "`cd` to the root of a git or svn repository"
    # save in case we have to come back
    set current_dir $PWD
    while test $PWD != '/'
        if test -x .git -o -x .vcs
            break;
        end
        cd ..
    end

    if test $PWD = '/'
        echo 'Backtracked all the way to "/", but no ".git" or ".svn" directory was ever found'
        cd $current_dir
    end
end
