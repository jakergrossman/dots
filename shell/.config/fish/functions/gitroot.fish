function gitroot --description "`cd` to the root of the git repository"
    # save in case we have to come back
    set current_dir $PWD
    while test $PWD != '/'
        if test -d .git
            break;
        end
        cd ..
    end

    if test $PWD = '/'
        echo 'Backtracked all the way to "/", but no ".git" directory was ever found'
        cd $current_dir
    end
end
